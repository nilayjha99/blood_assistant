//
//  UserModel.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-04.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import SwiftyJSON

class UserModel: NSObject, NSCoding {
  
    
    //properties
    var email: String?
    var name: String?
    var user_id: Int?
    var user_token: String?
    var fb_user_id: String?
    var user_role_id: Int?
    var blood_group_id: Int?
    var profile_id: Int?
    var phone_number: String?
    var address_geo: JSON?
    var gender: String?
    var address: String?
    
    //MARK: - Archiving Paths -
    // lookup the curent application's documents directory and create the file URL by appending meals to the end of the documents URL.
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("user")

    struct PropertyKey {
        static let email = "email"
        static let name = "name"
        static let user_id = "user_id"
        static let fb_user_id = "fb_user_id"
        static let user_token = "user_token"
        static let user_role_id = "user_role_id"
        static let blood_group_id = "blood_group_id"
        static let profile_id = "profile_id"
        static let phone_number = "phone_number"
        static let address_geo = "address_geo"
        static let gender = "gender"
        static let address = "address"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(email, forKey: PropertyKey.email)
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(user_id, forKey: PropertyKey.user_id)
        aCoder.encode(fb_user_id, forKey: PropertyKey.fb_user_id)
        aCoder.encode(user_token, forKey: PropertyKey.user_token)
        aCoder.encode(user_role_id, forKey: PropertyKey.user_role_id)
        aCoder.encode(blood_group_id, forKey: PropertyKey.blood_group_id)
        aCoder.encode(profile_id, forKey: PropertyKey.profile_id)
        aCoder.encode(phone_number, forKey: PropertyKey.phone_number)
        aCoder.encode(address_geo, forKey: PropertyKey.address_geo)
        aCoder.encode(gender, forKey: PropertyKey.gender)
        aCoder.encode(address, forKey: PropertyKey.address)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let Name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
        let Email = aDecoder.decodeObject(forKey: PropertyKey.email) as? String
        let User_id = aDecoder.decodeInteger(forKey: PropertyKey.user_id)
        let Fb_user_id = aDecoder.decodeObject(forKey: PropertyKey.fb_user_id) as? String
        let User_token = aDecoder.decodeObject(forKey: PropertyKey.user_token) as? String
        let User_role_id = aDecoder.decodeInteger(forKey: PropertyKey.user_role_id)
        let Blood_group_id = aDecoder.decodeInteger(forKey: PropertyKey.blood_group_id)
        let Profile_id = aDecoder.decodeInteger(forKey: PropertyKey.profile_id)
        let Phone_number = aDecoder.decodeObject(forKey: PropertyKey.phone_number) as? String
        let Address_geo = aDecoder.decodeObject(forKey: PropertyKey.address_geo) as? JSON
        let Gender = aDecoder.decodeObject(forKey: PropertyKey.gender) as? String
        let Address = aDecoder.decodeObject(forKey: PropertyKey.address) as? String
        
        self.init(email: Email, name: Name, user_id: User_id, user_token: User_token,
                  fb_user_id: Fb_user_id, user_role_id: User_role_id, blood_group_id: Blood_group_id,
                  profile_id: Profile_id, phone_number: Phone_number, address_geo: Address_geo,
                  gender: Gender, address: Address)
    }
    
    init(email: String?,
     name: String?,
     user_id: Int?,
     user_token: String?,
     fb_user_id: String?,
     user_role_id: Int?,
     blood_group_id: Int?,
     profile_id: Int?,
     phone_number: String?,
     address_geo: JSON?,
     gender: String?,
     address: String?) {
        self.email = email
        self.name = name
        self.user_id = user_id
        self.fb_user_id = fb_user_id
        self.user_token = user_token
        self.user_role_id = user_role_id
        self.blood_group_id = blood_group_id
        self.profile_id = profile_id
        self.phone_number = phone_number
        self.address_geo = address_geo
        self.gender = gender
        self.address = address
    }
    
}
