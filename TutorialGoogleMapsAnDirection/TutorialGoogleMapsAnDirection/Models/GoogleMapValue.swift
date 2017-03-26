//
//  GoogleMapValue.swift
//  TutorialGoogleMapsAnDirection
//
//  Created by Bùi Minh Tiến on 3/26/17.
//  Copyright © 2017 TienBM. All rights reserved.
//

import Foundation
import ObjectMapper

struct GoogleMapValue: Mappable {
    
    var text = ""
    var value: Int?
    
    init() {
    }
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        text    <- map["text"]
        value   <- map["value"]
    }
    
}
