//
//  DrawerContent.swift
//  BoersApp
//
//  Created by Alex Alekseev on 06.04.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit
import PanModal

class ProductInfoViewController: UIViewController {

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.scrollIndicatorInsets = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
            tableView.registerNibModels(nibModels:
                [ProductInfoViewCellModel.self, DetailImageTableViewCellModel.self])
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let dataSouce = ProductInfoDataSource()
    
    var jobNumer: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProductInfo(jobNum: jobNumer)
    }
    
    //    TODO: - Resolve dismissing problem
    //    func panModalWillDismiss() {
    //        ScannerViewController.startRunning()
    //    }
    
    private func getProductInfo(jobNum: String) {
        dataSouce.job = nil
        tableView.reloadData()
        activityIndicator.startAnimating()
        ApiClient.getJobs(jobNum) { (jobs, _) in
            if let jobs = jobs {
                if jobs.isEmpty {
                    self.showMessageAlert(title: "Error", message: "No jobs found", buttonTitle: "OK")
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

extension ProductInfoViewController: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil
    }
}
