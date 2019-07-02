//
//  DrawerContent.swift
//  BoersApp
//
//  Created by Alex Alekseev on 06.04.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit
import PanModal

class ProductInfoViewController: PanModalPresentbleViewController {

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.registerNibModels(nibModels:
                [ProductInfoViewCellModel.self, DetailImageTableViewCellModel.self])
        }
    }
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    private let dataSouce = ProductInfoDataSource()
    
    var jobNumber: String!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override var panScrollable: UIScrollView? {
        return tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = " "
        getProductInfo(from: jobNumber)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func getProductInfo(from jobNumber: String) {
        dataSouce.job = nil
        tableView.reloadData()
        activityIndicator.startAnimating()
        ApiClient.getJobs(jobNumber) { (jobs, _) in
            if let jobs = jobs {
                if jobs.isEmpty {
                    self.showMessageAlert(title: "Error", message: "No jobs found", buttonTitle: "OK")
                    return
                }
                self.dataSouce.job = jobs.first!
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.panModalSetNeedsLayoutUpdate()
            }
        }
    }
}

// MARK: - TableView DataSourcce

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

extension ProductInfoViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let types = dataSouce.typesForRow(at: indexPath)
        if types.section == .info && types.row == .partNum {
            if let partInfoVC = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "PartInfoVC") as? PartInfoViewController {
                partInfoVC.partNumber = dataSouce.job!.partNumber
                navigationController?.pushViewController(partInfoVC, animated: true)
            }
        }
    }
}
