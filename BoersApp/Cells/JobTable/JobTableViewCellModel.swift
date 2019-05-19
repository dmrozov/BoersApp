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
}

extension JobTableViewCellModel: CellViewModel {
    func setup(cell: JobTableViewCell) {
        if job.jobCompvare == true {
            cell.stateLabel.text = "Complete"
            cell.stateLabel.textColor = UIColor.green
        } else {
            cell.stateLabel.text = "Not ready"
            cell.stateLabel.textColor = UIColor.red
        }
    }
}
