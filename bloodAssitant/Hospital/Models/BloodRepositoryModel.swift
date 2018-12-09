//
//  BloodRepositoryModel.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-08.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

class BloodRepositoryModel {
    var blood_group_id: Int?
    var blood_repo_id: Int?
    var blood_units: Int?
    
    init(blood_group_id: Int?, blood_repo_id: Int?, blood_units: Int?) {
        self.blood_group_id = blood_group_id
        self.blood_repo_id = blood_repo_id
        self.blood_units = blood_units
    }
}
