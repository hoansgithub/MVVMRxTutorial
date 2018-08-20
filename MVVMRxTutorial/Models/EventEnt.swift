//
//  EventEnt.swift
//  MVVMRxTutorial
//
//  Created by Hoan Nguyen on 8/16/18.
//  Copyright © 2018 Hoan Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper
struct EventEnt : BaseModel {
    var id : String?
    var type : String?
    var avatarURLString : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        avatarURLString <- map["actor.avatar_url"]
    }
}
