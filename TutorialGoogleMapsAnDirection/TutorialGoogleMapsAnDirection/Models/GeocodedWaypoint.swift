//
//  GeocodedWaypoint.swift
//  TutorialGoogleMapsAnDirection
//
//  Created by Bùi Minh Tiến on 3/26/17.
//  Copyright © 2017 TienBM. All rights reserved.
//

import Foundation
import ObjectMapper

struct GeocodedWaypoint: Mappable {
    
    var geocoderStatus = ""
    var placeId = ""
    var types = [String]()
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        geocoderStatus <- map["geocoder_status"]
        placeId        <- map["place_id"]
        types          <- map["types"]
    }
    
}
