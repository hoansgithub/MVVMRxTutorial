//
//  APIClient.swift
//  MVVMRxTutorial
//
//  Created by Hoan Nguyen on 6/4/18.
//  Copyright © 2018 Hoan Nguyen. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire
import RxAlamofire
import ObjectMapper

enum APIError : Error {
    case invalidURL(url: String)
    case invalidResponseData(data: Any)
    case error(responseCode: Int, data: Any)
}

class APIClient {
    private func _request(_ input : APIInput) -> Observable<Any> {
        let manager = Alamofire.SessionManager.default
        return manager.rx.request(input.requestType
            , input.urlString
            , parameters: input.parameters
            , encoding: input.encoding
            , headers: input.headers)
            .flatMap({ (dataRequest) -> Observable<DataResponse<Any>> in
                return dataRequest.rx.responseJSON()
            }).map({(dataResponse) -> Any in
                return  try self.processDataResponse(dataResponse)
            })
    }
    
    private func processDataResponse(_ dataResponse : DataResponse<Any>) throws -> Any {
        let error : Error
        switch dataResponse.result {
        case .success(let value):
            if let statusCode = dataResponse.response?.statusCode {
                switch statusCode {
                case 200:
                    return value
                case 304:
                    error = ResponseError.notModified
                    break
                case 400:
                    error = ResponseError.invalidRequest
                case 401:
                    error = ResponseError.unauthorized
                case 403:
                    error = ResponseError.accessDenied
                case 404:
                    error = ResponseError.notFound
                case 405:
                    error = ResponseError.methodNotAllowed
                case 422:
                    error = ResponseError.validate
                case 500:
                    error = ResponseError.serverError
                case 502:
                    error = ResponseError.badGateway
                case 503:
                    error = ResponseError.serviceUnavailable
                case 504:
                    error = ResponseError.gatewayTimeout
                default :
                    error = ResponseError.unknown(statusCode: statusCode)
                    break
                }
            }
            else {
                error = ResponseError.noStatusCode
            }
            break
        case .failure(let err):
            error = err
            break
        }
        throw error
    }
    
    func request<T:Mappable>(_ input : APIInput) -> Observable<T> {
        return self._request(input).map({ (data) -> T in
            if let jsonData = data as? [String : Any],
                let item = T(JSON: jsonData) {
                return item
            } else {
                throw APIError.invalidResponseData(data: data)
            }
        })
    }
    
    func requestArray<T:Mappable>(_ input : APIInput) -> Observable<[T]> {
        return self._request(input).map({ (data) -> [T] in
            if let jsonData = data as? [[String : Any]] {
                let itemArr = Mapper<T>().mapArray(JSONArray: jsonData)
                return itemArr
            } else {
                throw APIError.invalidResponseData(data: data)
            }
        })
    }
}
