//
//  NavigationController.swift
//  BoersApp
//
//  Created by Alex Alekseev on 26.05.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit
import PanModal

class NavigationController: UINavigationController, PanModalPresentable {
    
    var rootVC: UIViewController!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pushViewController(rootVC, animated: false)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let viewController = super.popViewController(animated: animated)
        panModalSetNeedsLayoutUpdate()
        return viewController
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        panModalSetNeedsLayoutUpdate()
    }
    
    // MARK: - Pan Modal Presentable
    
    var panScrollable: UIScrollView? {
        return (topViewController as? PanModalPresentable)?.panScrollable
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeight
    }
    
    var shortFormHeight: PanModalHeight {
        return longFormHeight
    }
}
