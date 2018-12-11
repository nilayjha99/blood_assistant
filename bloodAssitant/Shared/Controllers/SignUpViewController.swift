//
//  SignUpViewController.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-04.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import MessageUI

class SignUpViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
     //MARK: - Variables -
    // reference to "sign up with facebook" button
    @IBOutlet weak var withFacebookButon: UIButton!
    // reference to submit button
    @IBOutlet weak var withEmailButton: BlackButton!
    // reference to confirm password field
    @IBOutlet weak var confirmPassword: BorderedTextField!
    // reference to password field
    @IBOutlet weak var userPassword: BorderedTextField!
    // reference to email field
    @IBOutlet weak var userEmail: BorderedTextField!
    // reference variable for userModel object
    var user: UserModel?
    
     // MARK: - Overriden Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
     //MARK: - Functions -
    
    // validate input fields
    func validateInputs() -> Bool {
        if !(self.userEmail.text?.isEmpty)! && !(self.userPassword.text?.isEmpty)! &&
            !(self.confirmPassword.text?.isEmpty)! {
            if self.userPassword.text == self.confirmPassword.text {
                if self.user == nil {
                self.user = UserModel(email: self.userEmail.text, name: nil, user_id: nil, user_token: nil, fb_user_id: nil, user_role_id: Constants.VOLUNTEER_ROLE_ID, blood_group_id: nil, profile_id: nil, phone_number: nil, lat: nil, lng: nil, gender: nil, address: nil, country_id: nil, city_id: nil)
                }
                self.user?.password = self.userPassword.text
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    // query facebook to get user details
    func getUserProfileFromFacebook() {
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
                        self.user = UserModel(
                            email: (response.dictionaryValue!["email"] as! String),
                            name: (response.dictionaryValue!["name"] as! String),
                            user_id: nil,
                            user_token: nil,
                            fb_user_id: (response.dictionaryValue!["id"] as! String),
                            user_role_id: Constants.VOLUNTEER_ROLE_ID, blood_group_id: nil,
                            profile_id: nil, phone_number: nil, lat: nil, lng: nil,
                            gender: nil, address: nil, country_id: nil, city_id: nil)
                        self.user?.fb_access_token = (AccessToken.current?.authenticationToken)!
                        self.userEmail.text = self.user?.email
                        break
                    case .failed(_):
                        print("failed")
                    }
        }
        connection.start()
    }
    
    // MARK: - Email related functions -
    func configureMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["nilayjha99@gmail.com"])
        mailComposerVC.setSubject("Help required!")
        mailComposerVC.setMessageBody("I need help regarding ...", isHTML: false)
        return mailComposerVC
    }
    
    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Could not send email", message: "Your device could not send email", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
     //MARK: - Actions -
    @IBAction func signUpWithEmail(_ sender: Any) {
        if !self.validateInputs() {
            return
        } else {
            performSegue(withIdentifier: "userSignup", sender: self)
        }
    }
    
   
    @IBAction func signUpWithFacebook(_ sender: Any) {
        let manager = LoginManager()
        manager.logIn(readPermissions: [.publicProfile, .email], viewController: self) {
            (result) in
            switch result {
            case .cancelled:
                print("user cancelled login")
            case .failed(let error):
                print("login failed with error = \(error.localizedDescription)")
            case .success( _, let declinedPermissions, let accessToken):
                print("access token = \(accessToken)")
                print("declined permissions = \(declinedPermissions)")
                if declinedPermissions.count == 0 {
                    self.getUserProfileFromFacebook()
                } else {
                    let alertBox = SharedValues.getErrorAlert(message: "Email permissio is required")
                    self.present(alertBox, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    
    @IBAction func openEmailApp(_ sender: UIButton) {
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showMailError()
        }
    }
    
    //MARK: - Navigation -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "userSignup":
            UserProfileViewController.passedUser = self.user
            if self.user?.fb_user_id != nil {
                UserProfileViewController.isSso = true
            }
        default:
            print("Unexpected Segue Identifier: \(String(describing: segue.identifier))")
        }
    }


}
