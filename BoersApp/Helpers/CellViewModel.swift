//
//  CellViewModel.swift
//  BoersApp
//
//  Created by Alex Alekseev on 06.04.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit

protocol CellViewAnyModel {
    static var cellAnyType: UIView.Type { get }
    func setupAny(cell: UIView)
}

protocol CellViewModel: CellViewAnyModel {
    associatedtype CellType: UIView
    func setup(cell: CellType)
}

extension CellViewModel {
    static var cellAnyType: UIView.Type {
        return CellType.self
    }
    func setupAny(cell: UIView) {
        guard let cellTyped = cell as? CellType else {
            assertionFailure("Wrong type in CellViewModel extension method")
            return
        }
        setup(cell: cellTyped)
    }
}

extension UITableView {
    func dequeueReusableCell(withModel model: CellViewAnyModel, for indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: type(of: model).cellAnyType)
        let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        model.setupAny(cell: cell)
        return cell
    }
    func registerNibModels(nibModels: [CellViewAnyModel.Type]) {
        for model in nibModels {
            let identifier = String(describing: model.cellAnyType)
            let nib = UINib(nibName: identifier, bundle: nil)
            self.register(nib, forCellReuseIdentifier: identifier)
        }
    }
}
