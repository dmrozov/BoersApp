//
//  UIStoryborad + InitViewController.swift
//  BoersApp
//
//  Created by Alex Alekseev on 03.06.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static func instantiateViewController(_ viewControllerName: ViewControllerName) -> UIViewController? {
        return viewControllerName.currentVC
    }
    
    enum ViewControllerName {
        case authVC, scannerVC, partInfoVC, productInfoVC
        var currentVC: UIViewController? {
            switch self {
            case .authVC:
                return UIStoryboard.main.instantiateViewController(withIdentifier: "AuthVC")
            case .scannerVC:
                return UIStoryboard.main.instantiateViewController(withIdentifier: "ScannerVC")
            case .partInfoVC:
                return UIStoryboard.main.instantiateViewController(withIdentifier: "PartInfoVC")
            case .productInfoVC:
                return UIStoryboard.main.instantiateViewController(withIdentifier: "ProductInfoVC")
            }
        }
    }
}
