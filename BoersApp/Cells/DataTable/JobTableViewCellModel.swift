//
//  DataTableViewCellModel.swift
//  BoersApp
//
//  Created by Alex Alekseev on 07.04.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import Foundation

struct JobTableViewCellModel {
    let job: Job
}

extension JobTableViewCellModel: CellViewModel {
    func setup(cell: JobTableViewCell) {
        cell.companyLabel.text = job.company
        cell.jobCompleteLabel.text = job.jobCompvare ? "completed" : "not completed"
        cell.jobNumerLabel.text = job.jobNum
        cell.partNumberLabel.text = job.partNum
        cell.revisionNumberLabel.text = job.revisionNum
        cell.drawNumberLabel.text = job.drawNum
        cell.partDescriptionNumber.text = job.partDescription
        cell.prodqtyLabel.text = job.prodQty
        cell.iumLabel.text = job.ium
        cell.qtyCompletedLabel.text = job.qtyCompvared
    }
}
