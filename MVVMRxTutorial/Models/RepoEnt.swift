//
//  RepoEnt.swift
//  MVVMRxTutorial
//
//  Created by Hoan Nguyen on 8/16/18.
//  Copyright © 2018 Hoan Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper
struct RepoEnt : BaseModel {
    var id = 0
    var name : String?
    var fullname : String?
    var urlString : String?
    var starCount = 0
    var folkCount = 0
    var avatarURLString : String?
    
    init(name : String) {
        self.name = name
    }
    
    init?(map : Map) {
        
    }
    
    mutating func mapping(map : Map) {
        id <- map["id"]
        name <- map["name"]
        fullname <- map["full_name"]
        urlString <- map["html_url"]
        starCount <- map["stargazers_count"]
        folkCount <- map["forks"]
        avatarURLString <- map["owner.avatar_url"]
    }
}
