//
//  APISTUFF.swift
//  BoersApp
//
//  Created by Dmitry Rozov on 09/04/2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import ObjectMapper
import Alamofire
import AlamofireObjectMapper

typealias ResultBlock<T> = (_ result: T?, _ error: Error?) -> Void
typealias RequestBlock = (Error?) -> Void

let serverUrl = "https://app2019api.boers.nl/api/"

struct ApiClient {

    private static var reachability: NetworkReachabilityManager?
    private static var savedCallback: (() -> Void)?

    // MARK: - Public funcs

    @discardableResult
    static func requestVoid(_ path: String, serverUrl: String = serverUrl,
                            method: HTTPMethod = .get, queryParameters: ConvertibleParameters? = nil, keyPath: String? = nil, bodyParameters: Parameters? = nil,
                            saveCallbackEnabled: Bool = true, completion: @escaping RequestBlock) -> DataRequest {
        return makeRequest(path, serverUrl: serverUrl, method: method, queryParameters: queryParameters, bodyParameters: bodyParameters).responseData(completionHandler: { (response) in
            completion(response.requestError)
            if response.requestError == .network, saveCallbackEnabled {
                savedCallback = {
                    ApiClient.requestVoid(path, serverUrl: serverUrl, method: method, queryParameters: queryParameters, keyPath: keyPath, bodyParameters: bodyParameters, completion: completion)
                }
            } else {
                savedCallback = nil
            }
        })
    }

    static func startReachabilityListener() {
        reachability = NetworkReachabilityManager(host: "google.com")
        reachability?.listener = { status in
            switch status {
            case .reachable:
                ApiClient.savedCallback?()
            default:
                break
            }
        }
        reachability?.startListening()
    }

    @discardableResult
    static func requestArray<T: Mappable>(_ path: String, serverUrl: String = serverUrl, method: HTTPMethod = .get,
                                          queryParameters: ConvertibleParameters? = nil, keyPath: String? = nil, bodyParameters: Parameters? = nil,
                                          saveCallbackEnabled: Bool = true, completion: @escaping ResultBlock<[T]>) -> DataRequest {
        return makeRequest(path, serverUrl: serverUrl, method: method,
                           queryParameters: queryParameters, bodyParameters: bodyParameters).responseArray(keyPath: keyPath) { (response: DataResponse<[T]>) in
            completion(response.value, response.requestError)
            if response.requestError == .network, saveCallbackEnabled {
                savedCallback = {
                    ApiClient.requestArray(path, serverUrl: serverUrl, method: method, queryParameters: queryParameters, keyPath: keyPath, bodyParameters: bodyParameters, completion: completion)
                }
            } else {
                savedCallback = nil
            }
        }
    }

    @discardableResult
    static func requestObject<T: Mappable>(_ path: String, serverUrl: String = serverUrl, method: HTTPMethod = .get, queryParameters: ConvertibleParameters? = nil,
                                           keyPath: String? = nil, bodyParameters: Parameters? = nil, saveCallbackEnabled: Bool = true, completion: @escaping ResultBlock<T>) -> DataRequest {
        return makeRequest(path, serverUrl: serverUrl, method: method, queryParameters: queryParameters, bodyParameters: bodyParameters).responseObject { (response: DataResponse<T>) in
            completion(response.value, response.requestError)
            if response.requestError == .network, saveCallbackEnabled {
                savedCallback = {
                    ApiClient.requestObject(path, serverUrl: serverUrl, method: method, queryParameters: queryParameters, keyPath: keyPath, bodyParameters: bodyParameters, completion: completion)
                }
            } else {
                savedCallback = nil
            }
        }
}
    // MARK: - Private funcs

    private static func makeRequest(_ path: String, serverUrl: String = serverUrl, method: HTTPMethod = .get,
                                    queryParameters: ConvertibleParameters? = nil, bodyParameters: Parameters? = nil) -> DataRequest {
        var fullParameters = ConvertibleParameters()
        if let parameters = queryParameters {
            for (key, value) in parameters {
                fullParameters.updateValue(value, forKey: key)
            }
        }
        let fullUrl = serverUrl + path + parametersString(from: fullParameters)

        let authHeaders = ["Content-Type" : "application/json"]
        return Alamofire.request(fullUrl, method: method, parameters: bodyParameters, encoding: JSONEncoding.default, headers: authHeaders)
    }

    private static func parametersString(from dict: ConvertibleParameters) -> String {
        var result = "?"
        for (key, value) in dict {
            if let value = value.toString().addingPercentEncoding(withAllowedCharacters: .alphanumerics) {
                result.append(key + "=" + value + "&")
            }
        }
        result.remove(at: result.index(before: result.endIndex))
        return result.replacingOccurrences(of: " ", with: "%20")
    }
}
