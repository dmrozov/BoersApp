//
//  JobModel.swift
//  BoersApp
//
//  Created by Alex Alekseev on 07.04.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import Foundation
import ObjectMapper

final class Job: Mappable {

    var jobComplete: Bool!
    var jobNumber: String!
    var partNumber: String!
    var revisionNumber: String!
    var drawNumber: String!
    var partDescription: String!
    var prodQty: String!
    var dedlineDate: String!
    var detailImage: String!

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        jobComplete <- map["jobcomplete"]
        jobNumber <- map["jobnum"]
        partNumber <- map["partnum"]
        revisionNumber <- map["revisionnum"]
        drawNumber <- map["drawnum"]
        partDescription <- map["partdescription"]
        prodQty <- map["ProdQty"]
        dedlineDate <- map["DueDate"]
        detailImage <- map["imageurl"]
    }
}
