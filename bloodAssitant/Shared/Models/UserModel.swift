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
    var user_id: String?
    var user_token: String?
    var fb_user_id: String?
    var user_role_id: String?
    var blood_group_id: String?
    var profile_id: String?
    var phone_number: String?
    var lat: Double?
    var lng: Double?
    var gender: String?
    var address: String?
    var country_id: Int?
    var city_id: Int?
    var password: String?
    
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
        static let lat = "lat"
        static let lng = "lng"
        static let gender = "gender"
        static let address = "address"
        static let country_id = "country_id"
        static let city_id = "city_id"
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
        aCoder.encode(lat, forKey: PropertyKey.lat)
        aCoder.encode(lng, forKey: PropertyKey.lng)
        aCoder.encode(gender, forKey: PropertyKey.gender)
        aCoder.encode(address, forKey: PropertyKey.address)
        aCoder.encode(country_id, forKey: PropertyKey.country_id)
        aCoder.encode(city_id, forKey: PropertyKey.city_id)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let Name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
        let Email = aDecoder.decodeObject(forKey: PropertyKey.email) as? String
        let User_id = aDecoder.decodeObject(forKey: PropertyKey.user_id) as? String
        let Fb_user_id = aDecoder.decodeObject(forKey: PropertyKey.fb_user_id) as? String
        let User_token = aDecoder.decodeObject(forKey: PropertyKey.user_token) as? String
        let User_role_id = aDecoder.decodeObject(forKey: PropertyKey.user_role_id) as? String
        let Blood_group_id = aDecoder.decodeObject(forKey: PropertyKey.blood_group_id) as? String
        let Profile_id = aDecoder.decodeObject(forKey: PropertyKey.profile_id) as? String
        let Phone_number = aDecoder.decodeObject(forKey: PropertyKey.phone_number) as? String
        let Lat = aDecoder.decodeObject(forKey: PropertyKey.lat) as? Double
        let Long = aDecoder.decodeObject(forKey: PropertyKey.lng) as? Double
        let Gender = aDecoder.decodeObject(forKey: PropertyKey.gender) as? String
        let Address = aDecoder.decodeObject(forKey: PropertyKey.address) as? String
        let Country_id = aDecoder.decodeObject(forKey: PropertyKey.country_id) as? Int
        let City_id = aDecoder.decodeObject(forKey: PropertyKey.city_id) as? Int
        
        self.init(email: Email, name: Name, user_id: User_id, user_token: User_token,
                  fb_user_id: Fb_user_id, user_role_id: User_role_id, blood_group_id: Blood_group_id,
                  profile_id: Profile_id, phone_number: Phone_number, lat: Lat, lng: Long,
                  gender: Gender, address: Address, country_id: Country_id, city_id: City_id)
    }
    
    init(email: String?,
     name: String?,
     user_id: String?,
     user_token: String?,
     fb_user_id: String?,
     user_role_id: String?,
     blood_group_id: String?,
     profile_id: String?,
     phone_number: String?,
     lat: Double?,
     lng: Double?,
     gender: String?,
     address: String?,
     country_id: Int?,
     city_id: Int?
     ) {
        self.email = email
        self.name = name
        self.user_id = user_id
        self.fb_user_id = fb_user_id
        self.user_token = user_token
        self.user_role_id = user_role_id
        self.blood_group_id = blood_group_id
        self.profile_id = profile_id
        self.phone_number = phone_number
        self.lat = lat
        self.lng = lng
        self.address = address
        self.gender = gender
        self.country_id = country_id
        self.city_id = city_id
    }
    
    func getIntegerValue(input: String) -> Int {
        return Int(input)!
    }
    /// Save/Archieve the meal details added/updated by the user.
    static func saveUser(user: UserModel) {
        // depricated as of new IOS 12 API
        // let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(self.meals, toFile: Meal.ArchiveURL.path)
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: false)
            try data.write(to: UserModel.ArchiveURL)
            print("User data successfully saved.")
        }   catch {
            fatalError("Error is saving meals data")
        }
    }
    
    /// Load/Unarchieve the meal details.
    static func loadUser() -> UserModel? {
        // Depricated as of new IOS 12 API
        // return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path)
        do {
            let userDataToRead = try NSData(contentsOf: UserModel.ArchiveURL, options: .dataReadingMapped)
            let userData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(Data(referencing: userDataToRead))
            print("Meals data successfully read.")
            return userData as? UserModel
        } catch {
            print("Error in reading meals data")
            return nil
        }
    }

}
