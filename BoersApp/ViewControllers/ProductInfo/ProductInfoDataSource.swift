//
//  ProductInfoDataSource.swift
//  BoersApp
//
//  Created by Dmitry Rozov on 21/05/2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import Foundation

class ProductInfoDataSource {

    var job: Job?

    var numberOfSections: Int {
        if job == nil { return 1 }
        return SectionType.allCases.count
    }

    func numberOfRows(in section: Int) -> Int {
        switch SectionType.allCases[section] {
        case .image: return 1
        case .info: return RowType.allCases.count
        }
    }
    
    func model(for indexPath: IndexPath) -> CellViewAnyModel? {
        guard let job = job else { return DetailImageTableViewCellModel(job: nil) }
        switch SectionType.allCases[indexPath.section] {
        case .image:
            return DetailImageTableViewCellModel(job: job)
        case .info:
            let info = RowType.allCases[indexPath.row]
            switch info {
            case .drawNumPartDesc:
                return ProductInfoViewCellModel(title: job.drawNumber, value: job.partDescription)
            case .job:
                let status = job.jobComplete ? "Complete" : "In progress"
                return ProductInfoViewCellModel(title: "Job", value: job.jobNumber, status: status)
            case .partNum:
                return ProductInfoViewCellModel(title: "Part", value: job.partNumber, showDisclosureIndicator: true)
            case .revision:
                return ProductInfoViewCellModel(title: "Revision", value: job.revisionNumber)
            case .qty:
                return ProductInfoViewCellModel(title: "QTY", value: String(job.prodQty))
            case .deadline:
                return ProductInfoViewCellModel(title: "Deadline", value: job.dedlineDate)
            }
        }
    }

    func typesForRow(at indexPath: IndexPath) -> (section: SectionType, row: RowType) {
        return (SectionType.allCases[indexPath.section], RowType.allCases[indexPath.row])
    }

    enum SectionType: CaseIterable {
        case image, info
    }

    enum RowType: CaseIterable {
        case job, partNum, drawNumPartDesc, revision, qty, deadline
    }
}
