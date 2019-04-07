//
//  DrawerContent.swift
//  BoersApp
//
//  Created by Alex Alekseev on 06.04.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit

class DrawerContentViewController: UIViewController {
    enum SectionType {
        case dataModelSection
    }
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.registerNibModels(nibModels:
                [DataTableViewCellModel.self])
        }
    }
    var dataModelArray: [DataModel] = []
    var sections: [SectionType] = [.dataModelSection]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DrawerContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch  sectionType {
        case .dataModelSection:
            return dataModelArray.count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sections[indexPath.section]
        let model: CellViewAnyModel
        switch sectionType {
        case .dataModelSection:
            let dataModel = dataModelArray[indexPath.row]
            model = DataTableViewCellModel(dataModel: dataModel)
        }
        return  tableView.dequeueReusableCell(withModel: model, for: indexPath)
    }
}
