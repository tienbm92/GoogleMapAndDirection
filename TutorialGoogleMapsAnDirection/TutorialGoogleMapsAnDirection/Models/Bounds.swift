//
//  Bounds.swift
//  TutorialGoogleMapsAnDirection
//
//  Created by Bùi Minh Tiến on 3/26/17.
//  Copyright © 2017 TienBM. All rights reserved.
//

import Foundation
import ObjectMapper

struct Bounds: Mappable {
    
    var northeast = Location()
    var southwest = Location()
    
    init() {
    }
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        northeast   <- map["northeast"]
        southwest   <- map["southwest"]
    }
    
}
