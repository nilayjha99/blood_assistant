//
//  HttpHandler.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-04.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import SwiftyJSON
import Alamofire

class MashapeHeadersAdapter: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue(HttpHandler.user_token!, forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}
class HttpHandler {
    static var user_id:Int?
    static var user_token: String?
    static var user_role_id: Int?
    static var sessionManager = Alamofire.SessionManager.default
    static func initAdapter(){
     self.sessionManager.adapter = MashapeHeadersAdapter()
    }
    
    static func post(url: String, data: Parameters, responseHandler: @escaping ((JSON, Bool) -> Void)) {
        var reqData = data
        if user_id ?? nil != nil {
            reqData["u_id"] = self.user_id
        }
        sessionManager.request(url, method: .post, parameters: reqData, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                responseHandler(json["payload"], json["success"].boolValue)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    static func get(url: String, queryParams: Parameters?, responseHandler: @escaping ((JSON, Bool) -> Void)) {
        var reqPar: Parameters? = queryParams
         if user_id ?? nil != nil {
            if reqPar ?? nil != nil {
            reqPar!["u_id"] = HttpHandler.user_id
            } else {
                reqPar = [
                    "u_id": HttpHandler.user_id!
                ]
            }
        }
        sessionManager.request(url, method: .get, parameters: reqPar, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                responseHandler(json["payload"], json["success"].boolValue)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    static func put(url: String, data: Parameters, responseHandler: @escaping ((JSON, Bool) -> Void)) {
        var reqData = data
        if user_id ?? nil != nil {
            reqData["u_id"] = self.user_id
        }
        sessionManager.request(url, method: .put, parameters: reqData, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                responseHandler(json["payload"], json["success"].boolValue)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    
}
