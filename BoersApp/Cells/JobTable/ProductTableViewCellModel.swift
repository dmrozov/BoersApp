//
//  DataTableViewCellModel.swift
//  BoersApp
//
//  Created by Alex Alekseev on 07.04.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit

struct ProductInfoViewCellModel {
    let title: String
    let value: String
    let status: String?
    let showDisclosureIndicator: Bool

    init(title: String, value: String, status: String? = nil, showDisclosureIndicator: Bool = false) {
        self.title = title
        self.value = value
        self.status = status
        self.showDisclosureIndicator = showDisclosureIndicator
    }
}

extension ProductInfoViewCellModel: CellViewModel {
    func setup(cell: ProductTableViewCell) {
        cell.titleLabel.text = title
        cell.valueLabel.text = value
        
        //TODO: - Не безопасно
        cell.statusLabel.text = status
        if cell.statusLabel.text == "Complete" {
            cell.statusLabel.textColor = #colorLiteral(red: 0.3019607843, green: 0.5803921569, blue: 0, alpha: 1)
        } else {
            cell.statusLabel.textColor = #colorLiteral(red: 0.8, green: 0, blue: 0, alpha: 1)
        }
        
        if showDisclosureIndicator {
            cell.accessoryType = .disclosureIndicator
        }
    }
}
