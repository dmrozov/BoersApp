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
        case .info: return InfoType.allCases.count
        }
    }
    
    func model(for indexPath: IndexPath) -> CellViewAnyModel? {
        guard let job = job else { return nil }
        switch SectionType.allCases[indexPath.section] {
        case .image:
            return DetailImageTableViewCellModel(job: job)
        case .info:
            let info = InfoType.allCases[indexPath.row]
            switch info {
            case .drawNumPartDesc:
                return ProductInfoViewCellModel(title: job.drawNumber, value: job.partDescription)
            case .job:
                let status = job.jobComplete ? "Complete" : "In progress"
                return ProductInfoViewCellModel(title: info.title, value: job.jobNumber, status: status)
            case .partNum:
                return ProductInfoViewCellModel(title: info.title, value: job.partNumber, showDisclosureIndicator: true)
            case .revision:
                return ProductInfoViewCellModel(title: info.title, value: job.revisionNumber)
            case .qty:
                return ProductInfoViewCellModel(title: info.title, value: String(job.prodQty))
            case .deadline:
                return ProductInfoViewCellModel(title: info.title, value: job.dedlineDate)
            }
        }
    }

    enum SectionType: CaseIterable {
        case image, info
    }

    enum InfoType: CaseIterable {
        case job, partNum, drawNumPartDesc, revision, qty, deadline

        var title: String {
            switch self {
            case .job: return "Job"
            case .partNum: return "Part"
            case .drawNumPartDesc: return ""
            case .revision: return "Revision"
            case .qty: return "QTY"
            case .deadline: return "Deadline"
            }
        }
    }
}
