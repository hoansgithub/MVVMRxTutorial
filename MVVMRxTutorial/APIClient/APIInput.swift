//
//  APIInput.swift
//  MVVMRxTutorial
//
//  Created by Hoan Nguyen on 6/4/18.
//  Copyright © 2018 Hoan Nguyen. All rights reserved.
//

import Foundation
import Alamofire
struct APIInput {
    var headers = [
        "Content-Type":"application/json; charset=utf-8",
        "Accept":"application/json"
    ]
    let urlString : String
    let requestType : HTTPMethod
    let encoding : ParameterEncoding
    let parameters : [String : Any]?
    let requireAccessToken : Bool
    
    init(urlString : String, params : [String : Any]?,extHeaders : [String : String]?, requestType : HTTPMethod, requireAccessToken : Bool = false) {
        self.urlString = urlString
        self.parameters = params
        self.requestType = requestType
        self.encoding = requestType == .get ? URLEncoding.default : JSONEncoding.default
        self.requireAccessToken = requireAccessToken
        if let extHeaders = extHeaders {
            for (key,val) in extHeaders {
                headers.updateValue(val, forKey: key)
            }
        }
    }
}
