//
//  SharedValues.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-04.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import SwiftyJSON
import Alamofire
import UIKit

class SharedValues {
    static var hospitals: JSON?
    static var hospitalNames = [String]()
    
    static func lodHospitals(country_id: Int, city_id: Int, handler: (() -> Void)?) {
        let requestParams: Parameters = [
            "country_id": country_id,
            "city_id": city_id
        ]
        HttpHandler.post(url: Constants.BASE_URL + "list/hospitals/", data: requestParams, responseHandler: { (json: JSON, success: Bool) in
            self.hospitals = json
            self.hospitalNames = self.getNames(collection: self.hospitals)
            if handler != nil {
                handler!()
            }
        })
     
    }
    
    static func getNames(collection: JSON?) -> [String] {
        var Names = [String]()
        for (_,subJson):(String, JSON) in collection! {
            Names.append(subJson["name"].stringValue)
        }
        return Names
    }
    
    static func getItemId(name:String, collection: JSON?) -> Int {
        var itemId: Int?
        for (_,subJson):(String, JSON) in collection! {
            if subJson["name"].stringValue == name {
                itemId = subJson["id"].intValue
            }
        }
        return itemId!
    }
    
    static func getItemName(id: Int, collection: JSON?) -> String {
        var itemName: String?
        for (_,subJson):(String, JSON) in collection! {
            if subJson["id"].intValue == id {
                itemName = subJson["name"].stringValue
            }
        }
        return itemName!
    }
    
    static func getErrorAlert(message: String)  -> UIAlertController {
        let alert = UIAlertController(title: "error", message: message, preferredStyle: .alert);
        let action = UIAlertAction(title: "ok", style: .default, handler: nil);
        alert.addAction(action);
        return alert;
    }
}
