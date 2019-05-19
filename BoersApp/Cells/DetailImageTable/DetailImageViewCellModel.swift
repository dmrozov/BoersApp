//
//  DetailImageViewCellModel.swift
//  BoersApp
//
//  Created by Alex Alekseev on 19.05.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit

struct DetailImageTableViewCellModel {
    let job: Job
}

extension DetailImageTableViewCellModel: CellViewModel {
    func setup(cell: DetailImageTableViewCell) {
        if let url = URL(string: job.detailImage) {
            do {
                let data = try Data(contentsOf: url)
                cell.detailImage.image = UIImage(data: data)
            } catch let err {
                print("Error : \(err.localizedDescription)")
            }
        }
    }
}
