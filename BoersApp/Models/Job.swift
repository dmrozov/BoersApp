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

    var company: String!
    var jobCompvare: Bool!
    var jobNum: String!
    var partNum: String!
    var revisionNum: String!
    var drawNum: String!
    var partDescription: String!
    var prodQty: String!
    var ium: String!
    var qtyCompvared: String!

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        company <- map["company"]
        jobCompvare <- map["jobcomplete"]
        jobNum <- map["jobnum"]
        partNum <- map["partnum"]
        revisionNum <- map["revisionnum"]
        drawNum <- map["drawnum"]
        partDescription <- map["partdescription"]
        prodQty <- map["prodqty"]
        ium <- map["ium"]
        qtyCompvared <- map["QtyCompleted"]
    }
}
