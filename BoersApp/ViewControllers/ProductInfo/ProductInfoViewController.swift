//
//  DrawerContent.swift
//  BoersApp
//
//  Created by Alex Alekseev on 06.04.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit
import Pulley
// TODO: - вернуть полосочку по дизайну вверху экрана
class ProductInfoViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
            tableView.registerNibModels(nibModels:
                [ProductInfoViewCellModel.self, DetailImageTableViewCellModel.self])
        }
    }

    let dataSouce = ProductInfoDataSource()

    func getProductInfo(jobNum: String) {
        dataSouce.job = nil
        tableView.reloadData()
        activityIndicator.startAnimating()
        ApiClient.getJobs(jobNum) { (jobs, _) in
            if let jobs = jobs {
                if jobs.isEmpty {
                    self.showMessageAlert(title: "Error", message: "No jobs found", buttonTitle: "OK") {
                        if let container = self.parent as? ContainerViewController {
                            container.setDrawerPosition(position: .collapsed, animated: true)
                        }
                    }

                }
                self.dataSouce.job = jobs.first!
                self.tableView.reloadData()
            }
            self.activityIndicator.stopAnimating()
        }
    }
}

extension ProductInfoViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSouce.numberOfRows(in: section)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSouce.numberOfSections
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = dataSouce.model(for: indexPath) else { return UITableViewCell() }
        return tableView.dequeueReusableCell(withModel: model, for: indexPath)
    }
}

extension ProductInfoViewController: PulleyDrawerViewControllerDelegate {

    func supportedDrawerPositions() -> [PulleyPosition] {
        return  [.partiallyRevealed, .open]
    }

    func partialRevealDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
        return 0
    }

    func drawerPositionDidChange(drawer: PulleyViewController, bottomSafeArea: CGFloat) {
        if drawer.drawerPosition == .open {
            ScannerViewController.stopRunning()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                ScannerViewController.startRunning()
            }
        }
    }
}
