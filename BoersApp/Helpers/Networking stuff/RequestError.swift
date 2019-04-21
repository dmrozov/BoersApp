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

    // TODO: - Translate to english
    var desc: String {
        switch self {
        case .network:
            return "Отсутствует Интернет-соединение. \nПроверьте подключение к wi-fi или \nсотовой сети и повторите попытку."
        case .serverError:
            return "Не удалось загрузить данные \nс портала «Виртуальная школа». \nПовторите попытку позднее."
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
