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
import FacebookCore
import FacebookLogin

class LogInViewController: UIViewController {

    @IBOutlet weak var accountSwitch: UISwitch!
    @IBOutlet weak var emailField: BorderedTextField!
    @IBOutlet weak var passwordField: BorderedTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let savedUser = UserModel.loadUser() {
            
            if savedUser.user_token != nil {
                let role = savedUser.user_role_id!
                HttpHandler.user_id = savedUser.user_id
                HttpHandler.user_token = savedUser.user_token
                HttpHandler.user_role_id = savedUser.user_role_id
                if role == Constants.DOCTOR_ROLE_ID {
                    self.performSeagueWith(id: "doctorProfile")
                } else {
                    self.performSeagueWith(id: "volunteerProfile")                }
            }
            
            
        }
    }

    func performSeagueWith(id: String) {
        DispatchQueue.main.async() {
            self.performSegue(withIdentifier: id, sender: self)
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
                user_id: data["id"].intValue,
                user_token: data["auth_token"].stringValue,
                fb_user_id: nil,
                user_role_id: Constants.DOCTOR_ROLE_ID,
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
            HttpHandler.user_id = data["id"].intValue
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
                user_id: data["id"].intValue,
                user_token: data["auth_token"].stringValue,
                fb_user_id: nil,
                user_role_id: Constants.VOLUNTEER_ROLE_ID,
                blood_group_id: data["blood_group"].intValue,
                profile_id: nil,
                phone_number: nil,
                lat: data["address_geo"]["lat"].doubleValue,
                lng: data["address_geo"]["long"].doubleValue,
                gender: data["gender"].stringValue,
                address: data["address"].stringValue,
                country_id: data["country_id"].intValue,
                city_id: data["city_id"].intValue
                )
            
            if let fb_user_id = data["fb_user_id"].string {
                    volunteer.fb_user_id = fb_user_id
            }

            UserModel.saveUser(user: volunteer)
            HttpHandler.user_id = data["profile_id"].intValue
            HttpHandler.user_role_id = Constants.DOCTOR_ROLE_ID
            HttpHandler.user_token = data["auth_token"].stringValue
            self.performSegue(withIdentifier: "volunteerProfile", sender: self)
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
    
    func performFacebookSso(fb_user_id: String, fb_access_token: String, email: String) {
        let parameters: Parameters = [
            "email": email,
            "fb_user_id": fb_user_id,
            "fb_access_token": fb_access_token,
            "user_role_id": Constants.VOLUNTEER_ROLE_ID
        ]
        HttpHandler.post(url: Constants.BASE_URL + "login/with/fb/", data: parameters, responseHandler: performVolunteerLogin)
    }
    
    func getUserProfile() {
        let connection = GraphRequestConnection()
        connection.add(
            GraphRequest(
                graphPath: "/me",
                parameters: ["fields":"id, name, email"],
                accessToken: AccessToken.current,
                httpMethod: .GET, apiVersion: GraphAPIVersion.defaultVersion)) {
                    response, result in
                    switch result {
                    case .success(let response):
                        self.performFacebookSso(fb_user_id: response.dictionaryValue!["id"] as! String,
                                           fb_access_token: (AccessToken.current?.authenticationToken)!,
                                           email: response.dictionaryValue!["email"] as! String)
                        break
                    case .failed(_):
                        print("failed")
                    }
        }
        connection.start()
    }
    
    @IBAction func loginWithFacebook(_ sender: Any) {
        let manager = LoginManager()
        manager.logIn(readPermissions: [.publicProfile, .email], viewController: self) {
            (result) in
            switch result {
            case .cancelled:
                print("user cancelled login")
            case .failed(let error):
                print("login failed with error = \(error.localizedDescription)")
            case .success( _, _, let accessToken):
                print("access token = \(accessToken)")
                self.getUserProfile()
            }
        }
    }
}
