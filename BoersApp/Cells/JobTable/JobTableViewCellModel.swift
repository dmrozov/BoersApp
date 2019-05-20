//
//  DataTableViewCellModel.swift
//  BoersApp
//
//  Created by Alex Alekseev on 07.04.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit

struct JobTableViewCellModel {
    let job: Job
    let title: String?
    let showDisclosureIndicator: Bool = false
}
// TODO: - полный сетап ячейки сделать
extension JobTableViewCellModel: CellViewModel {
    func setup(cell: JobTableViewCell) {
//        cell.valueLabel
    }
}
