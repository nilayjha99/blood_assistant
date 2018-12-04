//
//  HttpHandler.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-04.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import SwiftyJSON
import Alamofire

class HttpHandler {
    static var user_id:Int?
    static var user_token: String?
    static var user_role_id: Int?
//    "https://3344f8bb.ngrok.io/api/v1/login/with/email/"
    private func getHttpHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Authorization": "Token \(HttpHandler.user_token ??  "user_toke")",
        ]
        return headers
    }
    
    static func post(url: String, data: Parameters, responseHandler: @escaping ((JSON) -> Void)) {
        Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                responseHandler(json["payload"])
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    static func get(url: String, queryParams: Parameters, responseHandler: @escaping ((JSON) -> Void)) {
        Alamofire.request(url, method: .get, parameters: queryParams, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                responseHandler(json["payload"])
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    static func put(url: String, data: Parameters, responseHandler: @escaping ((JSON) -> Void)) {
        Alamofire.request(url, method: .put, parameters: data, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                responseHandler(json["payload"])
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
