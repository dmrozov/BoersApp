//
//  DataTableViewCellModel.swift
//  BoersApp
//
//  Created by Alex Alekseev on 07.04.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import Foundation

struct DataTableViewCellModel {
    let dataModel: DataModel
}

extension DataTableViewCellModel: CellViewModel {
    func setup(cell: DataTableViewCell) {
        cell.labelDataModel.text = dataModel.name
    }
}
