//
//  PartInfoViewController.swift
//  BoersApp
//
//  Created by Dmitry Rozov on 29/05/2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit

class PartInfoViewController: PanModalPresentbleViewController {

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.registerNibModels(nibModels: [ProductInfoViewCellModel.self])
        }
    }
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    private let dataSouce = PartInfoDataSource()
    var partNumber: String!

    override var panScrollable: UIScrollView? {
        return tableView
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        getPartInfo(from: partNumber)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func getPartInfo(from partNumber: String) {
        dataSouce.part = nil
        tableView.reloadData()
        activityIndicator.startAnimating()
        ApiClient.getParts(partNumber) { (parts, _) in
            if let parts = parts {
                if parts.isEmpty {
                    self.showMessageAlert(title: "Error", message: "No part info found", buttonTitle: "OK")
                }
                self.dataSouce.part = parts.first!
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.panModalSetNeedsLayoutUpdate()
            }
        }
    }
}

// MARK: - TableView DataSourcce

extension PartInfoViewController: UITableViewDataSource {

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
