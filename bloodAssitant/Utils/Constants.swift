//
//  Constants.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-04.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//
import MapKit

class Constants {
    static let COUNTRY_ID = 1
    static let CITY_ID = 1
    static let COUNTRY_NAME = "Canada"
    static let CITY_NAME = "Regina"
    static let VOLUNTEER_ROLE_ID = 1
    static let DOCTOR_ROLE_ID = 2
    static let BASE_URL = "http://ec2-18-221-249-137.us-east-2.compute.amazonaws.com/api/v1/"
    static let BLOOD_GROUPS = [
        "A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"
    ]
    static let GENDERS = ["male", "female", "other"]
    static let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    static let pLat = 50.445210
    static let pLong = -104.618896
}
