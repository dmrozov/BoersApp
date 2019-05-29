//
//  PanModalPresentbleViewController.swift
//  BoersApp
//
//  Created by Dmitry Rozov on 29/05/2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit
import PanModal

class PanModalPresentbleViewController: UIViewController, PanModalPresentable {

    var panScrollable: UIScrollView? { return nil }

    func panModalSetNeedsLayoutUpdate() {
        (self.navigationController as? NavigationController)?.panModalSetNeedsLayoutUpdate()
    }
}
