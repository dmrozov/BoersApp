//
//  DrawerContent.swift
//  BoersApp
//
//  Created by Alex Alekseev on 06.04.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit
import Pulley

class ProductInfoViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    enum SectionType {
        case jobsSection
    }

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
            tableView.registerNibModels(nibModels:
                [JobTableViewCellModel.self])
        }
    }

    var jobs: [Job] = [] {
        didSet {
            jobs.isEmpty ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }
    }
    var sections: [SectionType] = [.jobsSection]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func getProductInfo(jobNum: String) {
        jobs.removeAll()
        tableView.reloadData()
        ApiClient.getJobs(jobNum) { (jobs, error) in
            if let jobs = jobs {
                if jobs.isEmpty {
                    self.showMessageAlert(title: "Error", message: "No jobs found", buttonTitle: "OK") {
                        if let container = self.parent as? ContainerViewController {
                            container.setDrawerPosition(position: .collapsed, animated: true)
                        }
                    }

                }
                self.jobs = jobs
                self.tableView.reloadData()
            }
        }
    }
}

extension ProductInfoViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch  sectionType {
        case .jobsSection:
            return jobs.count
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sections[indexPath.section]
        let model: CellViewAnyModel
        switch sectionType {
        case .jobsSection:
            model = JobTableViewCellModel(job: jobs[indexPath.row])
        }
        return tableView.dequeueReusableCell(withModel: model, for: indexPath)
    }
}

extension ProductInfoViewController: PulleyDrawerViewControllerDelegate {

    func supportedDrawerPositions() -> [PulleyPosition] {
        return  [.collapsed, .open]
    }

    func collapsedDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
        return 0
    }

    func drawerPositionDidChange(drawer: PulleyViewController, bottomSafeArea: CGFloat) {
        if drawer.drawerPosition == .open {
            CaptureSession.instance.captureSession?.stopRunning()
        } else {
            CaptureSession.instance.captureSession?.startRunning()
        }
    }
}
