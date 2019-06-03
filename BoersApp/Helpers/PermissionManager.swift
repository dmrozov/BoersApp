//
//  PermissionManager.swift
//  BoersApp
//
//  Created by Alex Alekseev on 06.04.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit
import AVKit

/**
 Allows to check and request different permissions
 
 * Easily check
 
 `if PermissionsManager.isAllowed(type: .camera) { ... }`
 
 * Request required permission
 
 `PermissionsManager.requireAccess(forType: .camera) { granted in }`
 
 */

enum PermissionsType: String {
    case camera
}

final class PermissionsManager {
    private enum PermissionConstants {
        static let askPhrases = [PermissionsType.camera: "camera".localized]
        static let askForAccess = "Please, provide app access to ".localized
        static let accessError = "Access error".localized
        static let cancel = "Cancel".localized
        static let settings = "Settings".localized
    }
    /// Helps to perform any action only if required permission is granted.
    /// Displays an alert with invitation to the Settings app if first request was rejected by the user
    ///
    /// - parameter from: `UIViewController` for alert invitation to be presented on
    /// - parameter to: Type of required permission
    /// - parameter completion: `Bool` value describing whether was access granted or not
    static func requireAccess(from controller: UIViewController,
                              to type: PermissionsType,
                              completion: @escaping (Bool) -> Void) {
        if !PermissionsManager.isAllowed(type: type) {
            PermissionsManager.requestAccess(forType: type) { success in
                 DispatchQueue.main.async {
                completion(success)
                if !success {
                    alertForSettingsWith(type: type, on: controller)
                    }
                }
            }
        } else {
            completion(true)
        }
    }
    /**
     Checks if user has granted access to `Type`
     
     - parameter type: Type of permission to check. Check out `Type` for possible values
     - returns: `Bool` describing if access is granted
     */
    static func isAllowed(type: PermissionsType) -> Bool {
        switch type {
        case .camera:
            return AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .authorized
        }
    }
    private static func requestAccess(forType: PermissionsType, completion: @escaping (Bool) -> Void) {
        if isAllowed(type: forType) {
            completion(true)
            return
        }
        switch forType {
        case .camera:
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { result in
                completion(result)
            }
        }
    }
    private static func alertForSettingsWith(type: PermissionsType, on viewController: UIViewController) {
        let phrase = PermissionConstants.askPhrases[type]
        assert(phrase != nil, "[PermissionsManager] Unknown Type passed")
        let messageFull = "\(PermissionConstants.askForAccess) \(phrase!)"
        viewController.showConfirmationAlert(title: PermissionConstants.accessError,
                                             message: messageFull,
                                             buttonFirstTitle: PermissionConstants.settings,
                                             buttonSecondTitle: PermissionConstants.cancel,
                                             firstAction: { openSettings() })
    }
    /**
     Allows to easily open Settings app for editing granted permissions.
     
     Make sure to **inform user** before opening Settings, also don't open it without user's confirmation
     */
    static func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}
