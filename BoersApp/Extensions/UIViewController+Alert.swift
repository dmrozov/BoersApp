//
//  UIViewController+Alert.swift
//  BoersApp
//
//  Created by Alex Alekseev on 06.04.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit

extension UIViewController {
    func showMessageAlert(title: String?, message: String? = nil,
                          buttonTitle: String? = "Ок".localized, action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default) { _ in
            if let action = action { action() }
        })
        self.present(alert, animated: true, completion: nil)
    }
    func showConfirmationAlert(title: String?, message: String? = nil,
                               buttonFirstTitle: String? = "Ок".localized,
                               buttonSecondTitle: String? = "Cancel".localized,
                               firstAction: (() -> Void)? = nil, secondAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonFirstTitle, style: .default) { _ in
            if let action = firstAction { action() }
        })
        alert.addAction(UIAlertAction(title: buttonSecondTitle, style: .default) { _ in
            if let action = secondAction { action() }
        })
        self.present(alert, animated: true, completion: nil)
    }
}
