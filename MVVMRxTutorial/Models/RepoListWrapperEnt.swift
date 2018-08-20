//
//  RepoListWrapperEnt.swift
//  MVVMRxTutorial
//
//  Created by Hoan Nguyen on 8/16/18.
//  Copyright © 2018 Hoan Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper
struct RepoListWrapperEnt : BaseModel {
    
    
    var repos : [RepoEnt]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        repos <- map["items"]
    }
    
    
}
