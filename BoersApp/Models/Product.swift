//
//  Product.swift
//  BoersApp
//
//  Created by Dmitry Rozov on 16/03/2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import Foundation

struct Product {
    //swiftlint:disable identifier_name
    let id: Int
    //swiftlint:enable identifier_name
    let name: String
    let code: String
    let steps: [Step]
}
