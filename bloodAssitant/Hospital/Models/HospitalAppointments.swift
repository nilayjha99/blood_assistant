//
//  HospitalAppointments.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-09.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

class HospitalAppointments {
    var id: Int?
    var donor_id: Int?
    var donor_name: String?
    var date: String?
    var blood_group_id: Int?
    
    init(id: Int?, donor_id: Int?, donor_name: String?, date: String?, blood_group_id: Int?) {
        self.id = id
        self.donor_id = donor_id
        self.donor_name = donor_name
        self.date = date
        self.blood_group_id = blood_group_id
    }
}
