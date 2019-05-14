//
//  ScannerDataProcessor.swift
//  BoersApp
//
//  Created by Alex Alekseev on 14.05.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import Foundation

enum ScannerDataProcessor {
    
    static func extractID(from stringURL: String) -> String? {
        if let url = URL(string: stringURL), let productNumber = url.queryParameters?["Id"] {
            return productNumber
        }
        if let productNumber = stringURL.components(separatedBy: "/").last {
            if Int(productNumber) == nil { return nil }
            return productNumber
        }
        return nil
    }
}
