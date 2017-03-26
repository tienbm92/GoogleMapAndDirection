//
//  Location.swift
//  TutorialGoogleMapsAnDirection
//
//  Created by Bùi Minh Tiến on 3/26/17.
//  Copyright © 2017 TienBM. All rights reserved.
//

import Foundation
import ObjectMapper

struct Location: Mappable {
    
    var latitude = 0.0
    var longtidude = 0.0
    
    init() {
    }
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        latitude    <- map["lat"]
        longtidude  <- map["lng"]
    }
    
}
