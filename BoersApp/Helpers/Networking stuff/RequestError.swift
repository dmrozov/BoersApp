//
//  RequestError.swift
//  BoersApp
//
//  Created by Dmitry Rozov on 21/04/2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import Foundation
import Alamofire

enum RequestError: Error {
    case network
    case serverError

    var desc: String {
        switch self {
        case .network:
            return "No wi-Fi connection. Check your wi-fi connection and try again."
        case .serverError:
            return "Data loading error. Try again later."
        }
    }
}

extension DataResponse {
    var requestError: RequestError? {
        if let error = error {
            if (error as NSError).domain == NSURLErrorDomain {
                return .network
            } else if let serverError = error as? RequestError {
                return serverError
            } else {
                return .serverError
            }
        }
        return nil
    }
}
