//
//  Part.swift
//  BoersApp
//
//  Created by Alex Alekseev on 29.05.2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import ObjectMapper

final class Part: Mappable {
    
    var partNumber: String!
    var description: String!
    var typeCode: String!
    var revisionNumber: String!
    var revShortDesc: String!
    var drawNumber: String!
    var lastOrder: Int!
    var lastJob: String!
    var lastPO: Int!
    var dimcode: String!
    var demandQty: Int!
    var onhandQty: Int!
    var imageUrl: String!
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        partNumber <- map["partnum"]
        description <- map["PartDescription"]
        typeCode <- map["TypeCode"]
        revisionNumber <- map["RevisionNum"]
        revShortDesc <- map["RevShortDesc"]
        drawNumber <- map["DrawNum"]
        lastOrder <- map["Last_order"]
        lastJob <- map["Last_Job"]
        lastPO <- map["Last_PO"]
        dimcode <- map["dimcode"]
        demandQty <- map["demandqty"]
        onhandQty <- map["onhandqty"]
        imageUrl <- map["imageurl"]
    }
}
