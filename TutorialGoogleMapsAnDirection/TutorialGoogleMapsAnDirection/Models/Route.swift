//
//  Route.swift
//  TutorialGoogleMapsAnDirection
//
//  Created by Bùi Minh Tiến on 3/26/17.
//  Copyright © 2017 TienBM. All rights reserved.
//

import Foundation
import ObjectMapper

struct Route: Mappable {
    
    var bounds = Bounds()
    var copyrights = ""
    var legs = [Leg]()
    var overviewPolyline = Polyline()
    var summary = ""
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        bounds              <- map["bounds"]
        copyrights          <- map["copyrights"]
        legs                <- map["legs"]
        overviewPolyline    <- map["overview_polyline"]
        summary             <- map["summary"]
    }
    
}
