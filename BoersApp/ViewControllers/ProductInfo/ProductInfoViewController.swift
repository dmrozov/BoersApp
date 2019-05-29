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
            getProductInfo(jobNum: jobNumer)
        }
    }
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    private let dataSouce = ProductInfoDataSource()
    
    var jobNumer: String!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override var panScrollable: UIScrollView? {
        return tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.registerNibModels(nibModels:
            [ProductInfoViewCellModel.self, DetailImageTableViewCellModel.self])
        getProductInfo(jobNum: jobNumer)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
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
