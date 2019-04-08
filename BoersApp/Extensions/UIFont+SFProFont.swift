//
//  UIFont+SFProText.swift
//  BoersApp
//
//  Created by Alex Alekseev on 08.04.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit

extension UIFont {
    enum SFProTextWeight: String {
        case heavy = "SFProText-Heavy"
        case lightItalic = "SFProText-LightItalic"
        case heavyItalic = "SFProText-HeavyItalic"
        case medium = "SFProText-Medium"
        case italic = "SFProText-Italic"
        case bold = "SFProText-Bold"
        case semiboldItalic = "SFProText-SemiboldItalic"
        case light = "SFProText-Light"
        case mediumItalic = "SFProText-MediumItalic"
        case boldItalic = "SFProText-BoldItalic"
        case regular = "SFProText-Regular"
        case semibold = "SFProText-Semibold"
    }
    enum FedraSansProtWeight: String {
        case bold = "FedraSansPro-Bold"
        case book = "FedraSansPro-Book"
        case medium = "FedraSansPro-Medium"
    }
    class func sfProText(_ weight: SFProTextWeight, size: CGFloat) -> UIFont {
        return UIFont(name: weight.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    class func fedraSansPro(_ weight: FedraSansProtWeight, size: CGFloat) -> UIFont {
        return UIFont(name: weight.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
