//
//  AuthViewController.swift
//  BoersApp
//
//  Created by Alex Alekseev on 31.03.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    @IBAction func openWiFiSettings(_ sender: Any) {
            print("Opening Wi-Fi settings.")
            
            let shared = UIApplication.shared
            let url = URL(string: UIApplication.openSettingsURLString)!
            
            if #available(iOS 10.0, *) {
                shared.open(url)
            } else {
                shared.openURL(url)
            }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
