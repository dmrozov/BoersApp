//
//  PartInfoDataSource.swift
//  BoersApp
//
//  Created by Alex Alekseev on 29.05.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import Foundation

class PartInfoDataSource {
    
    var part: Part?
    
    var numberOfSections: Int {
        return SectionType.allCases.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        if part == nil { return 0 }
        switch SectionType.allCases[section] {
        case .info: return RowType.allCases.count
        }
    }
    
    func model(for indexPath: IndexPath) -> CellViewAnyModel? {
        guard let part = part else { return nil }
        switch SectionType.allCases[indexPath.section] {
        case .info:
            let info = RowType.allCases[indexPath.row]
            switch info {
            case .part:
                return ProductInfoViewCellModel(title: "Part", value: part.partNumber)
            case .partDesciption:
                return ProductInfoViewCellModel(title: "Description", value: part.description)
            case .lRev:
                return ProductInfoViewCellModel(title: "Rev", value: part.revisionNumber)
            case .desc:
                return ProductInfoViewCellModel(title: "Desc", value: part.revShortDesc)
            case .drawing:
                return ProductInfoViewCellModel(title: "Drawing", value: part.drawNumber)
            case .type:
                return ProductInfoViewCellModel(title: "Type", value: part.typeCode)
            case .demand:
                return ProductInfoViewCellModel(title: "Demand", value: part.demandQty.toString() + " " + part.dimcode)
            case .onhand:
                return ProductInfoViewCellModel(title: "Onhand", value: part.onhandQty.toString() + " " + part.dimcode)
            }
        }
    }
    
    enum SectionType: CaseIterable {
        case info
    }
    
    enum RowType: CaseIterable {
        case part, partDesciption, lRev, desc, drawing, type, demand, onhand
    }
}
