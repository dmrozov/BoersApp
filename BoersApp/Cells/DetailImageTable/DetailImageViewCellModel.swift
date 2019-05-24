//
//  DetailImageViewCellModel.swift
//  BoersApp
//
//  Created by Alex Alekseev on 19.05.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit
import Alamofire

struct DetailImageTableViewCellModel {
    let job: Job?
}

extension DetailImageTableViewCellModel: CellViewModel {
    func setup(cell: DetailImageTableViewCell) {
        cell.detailImage.image = #imageLiteral(resourceName: "product_template.png")
        guard let job = job else { return }
        Alamofire.request(job.detailImage).responseData { result in
            if let data = result.data, let image = UIImage(data: data) {
                cell.detailImage.image = image
            }
        }
    }
}
