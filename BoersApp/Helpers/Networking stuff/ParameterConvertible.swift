//
//  ParameterConvertible.swift
//  BoersApp
//
//  Created by Dmitry Rozov on 21/04/2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import Foundation

typealias ConvertibleParameters = [String: ParameterConvertible]

protocol ParameterConvertible {
    func toString() -> String
}

extension String: ParameterConvertible {
    func toString() -> String {
        return self
    }
}

extension Int: ParameterConvertible {
    func toString() -> String {
        return String(self)
    }
}

extension Array where Element: ParameterConvertible {
    func toString() -> String {
        return map { $0.toString() }.joined(separator: ",")
    }
}
