//
//  NavigationController.swift
//  BoersApp
//
//  Created by Alex Alekseev on 26.05.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit
import PanModal

class NavigationController: UINavigationController {
    
    private var rootViewController: UIViewController!
    private var willDismissCallback: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pushViewController(rootViewController, animated: false)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let viewController = super.popViewController(animated: animated)
        panModalSetNeedsLayoutUpdate()
        return viewController
    }

    static func with(_ rootViewController: UIViewController,
                     willDismissCallback: (() -> Void)? = nil) -> NavigationController {
        let navigationController = NavigationController()
        navigationController.rootViewController = rootViewController
        navigationController.willDismissCallback = willDismissCallback
        return navigationController
    }
}

// MARK: - PanModalPresentable

extension NavigationController: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return (topViewController as? PanModalPresentable)?.panScrollable
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeight
    }
    
    var shortFormHeight: PanModalHeight {
        return longFormHeight
    }

    func panModalWillDismiss() {
        willDismissCallback?()
    }
}
