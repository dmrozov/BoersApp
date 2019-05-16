//
//  ApiRequests.swift
//  BoersApp
//
//  Created by Dmitry Rozov on 21/04/2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import Foundation

typealias FetchJobs = ResultBlock<[Job]>

extension ApiClient {

    static func getJobs(_ number: String, completion: @escaping FetchJobs) {
        ApiClient.requestArray("job?JobNum=" + number, completion: completion)
    }
}
