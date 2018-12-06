//
//  LogInViewController.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-04.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LogInViewController: UIViewController {

    @IBOutlet weak var accountSwitch: UISwitch!
    @IBOutlet weak var emailField: BorderedTextField!
    @IBOutlet weak var passwordField: BorderedTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedUser = UserModel.loadUser() {
            // The name must not be empty
            SharedValues.loadCountries(handler: {() in
                if savedUser.user_token != nil {
                    let role = savedUser.getIntegerValue(input: savedUser.user_role_id!)
                    if role == Constants.DOCTOR_ROLE_ID {
                        self.performSegue(withIdentifier: "doctorProfile", sender: self)
                    } else {
                        let userCountry = SharedValues.getItemName(id: savedUser.country_id!, collection: SharedValues.countries)
                        SharedValues.loadCities(country: userCountry, handler: {() in
                            self.performSegue(withIdentifier: "volunteerProfile", sender: self)
                        })
                    }
                }
            })
           
            }

        }

        // Do any additional setup after loading the view.
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func performDocorLogin(data: JSON, isSucess: Bool) {
        if isSucess {
            let doctor = UserModel(
                email: data["email"].stringValue,
                name: data["name"].stringValue,
                user_id: String(data["id"].intValue),
                user_token: data["auth_token"].stringValue,
                fb_user_id: nil,
                user_role_id: String(Constants.DOCTOR_ROLE_ID),
                blood_group_id: nil,
                profile_id: nil,
                phone_number: data["phone_number"].stringValue,
                lat: data["address_geo"]["lat"].doubleValue,
                lng: data["address_geo"]["long"].doubleValue,
                gender: nil,
                address: data["address"].stringValue,
                country_id: data["country_id"].intValue,
                city_id: data["city_id"].intValue
                )
    //        print(data["id"].intValue)
            UserModel.saveUser(user: doctor)
            HttpHandler.user_id = data["profile_id"].intValue
            HttpHandler.user_role_id = Constants.DOCTOR_ROLE_ID
            HttpHandler.user_token = data["auth_token"].stringValue
            HttpHandler.initAdapter()
            performSegue(withIdentifier: "doctorProfile", sender: self)
        }
    }
    
    func performVolunteerLogin(data: JSON, isSucess: Bool) {
        if isSucess {
            let volunteer = UserModel(
                email: data["email"].stringValue,
                name: data["name"].stringValue,
                user_id: String(data["id"].intValue),
                user_token: data["auth_token"].stringValue,
                fb_user_id: nil,
                user_role_id: String(Constants.VOLUNTEER_ROLE_ID),
                blood_group_id: String(data["blood_group"].intValue),
                profile_id: nil,
                phone_number: nil,
                lat: data["address_geo"]["lat"].doubleValue,
                lng: data["address_geo"]["long"].doubleValue,
                gender: data["gender"].stringValue,
                address: data["address"].stringValue,
                country_id: data["country_id"].intValue,
                city_id: data["city_id"].intValue
                )
            UserModel.saveUser(user: volunteer)
            HttpHandler.user_id = data["profile_id"].intValue
            HttpHandler.user_role_id = Constants.DOCTOR_ROLE_ID
            HttpHandler.user_token = data["auth_token"].stringValue
            HttpHandler.initAdapter()
            SharedValues.loadCountries(handler: { () in
                let userCountry = SharedValues.getItemName(id: volunteer.country_id!, collection: SharedValues.countries)
                SharedValues.loadCities(country: userCountry, handler: {() in
                    HttpHandler.initAdapter()
                    self.performSegue(withIdentifier: "volunteerProfile", sender: self)
                })
            })
           
        }
    }
    
    @IBAction func loginWithEmail(_ sender: UIButton) {
        let email = self.emailField.text
        let password = self.passwordField.text
        if (email?.isEmpty ?? true) || (password?.isEmpty ?? true) {
            return
        }
        var requestParameters: Parameters = [
            "email": email!,
            "password": password!
        ]
        if self.accountSwitch.isOn {
            requestParameters["user_role_id"] = Constants.DOCTOR_ROLE_ID
            HttpHandler.post(url: Constants.BASE_URL + "login/with/email/", data: requestParameters, responseHandler: performDocorLogin)
        } else {
            requestParameters["user_role_id"] = Constants.VOLUNTEER_ROLE_ID
            HttpHandler.post(url: Constants.BASE_URL + "login/with/email/", data: requestParameters, responseHandler: performVolunteerLogin)
        }
    }
}
