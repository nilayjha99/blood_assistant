//
//  BloodRequestsModel.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-05.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//
class BloodRequestsModel {
    var id: Int?
    var to_user_id: Int?
    var units: Int?
    var blood_group_name: String?
    var bood_group_id: Int?
    var to_user_name:String?
    
    init(id: Int?, to_user_id: Int?, units: Int?, blood_group_name: String?, blood_group_id: Int?, to_user_name: String?) {
        self.id = id
        self.to_user_id = to_user_id
        self.units = units
        self.blood_group_name = blood_group_name
        self.bood_group_id = blood_group_id
        self.to_user_id = to_user_id
        self.to_user_name = to_user_name
    }
}
