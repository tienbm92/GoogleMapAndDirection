//
//  Step.swift
//  TutorialGoogleMapsAnDirection
//
//  Created by Bùi Minh Tiến on 3/26/17.
//  Copyright © 2017 TienBM. All rights reserved.
//

import Foundation
import ObjectMapper

struct Step: Mappable {
    
    var distance = GoogleMapValue()
    var duration = GoogleMapValue()
    var endLocation = Location()
    var htmlInstructions = ""
    var polyline = Polyline()
    var startLocation = Location()
    var travelMode = ""
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        distance            <- map["distance"]
        duration            <- map["duration"]
        endLocation         <- map["end_location"]
        htmlInstructions    <- map["html_instructions"]
        polyline            <- map["polyline"]
        startLocation       <- map["start_location"]
        travelMode          <- map["travel_mode"]
    }
    
}
