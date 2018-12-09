//
//  SignUpViewController.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-04.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var withFacebookButon: UIButton!
    @IBOutlet weak var withEmailButton: BlackButton!
    @IBOutlet weak var confirmPassword: BorderedTextField!
    @IBOutlet weak var userPassword: BorderedTextField!
    @IBOutlet weak var userEmail: BorderedTextField!
    var user: UserModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func validateInputs() -> Bool {
        if !(self.userEmail.text?.isEmpty)! && !(self.userPassword.text?.isEmpty)! &&
            !(self.confirmPassword.text?.isEmpty)! {
            if self.userPassword.text == self.confirmPassword.text {
                self.user = UserModel(email: self.userEmail.text, name: nil, user_id: nil, user_token: nil, fb_user_id: nil, user_role_id: Constants.VOLUNTEER_ROLE_ID, blood_group_id: nil, profile_id: nil, phone_number: nil, lat: nil, lng: nil, gender: nil, address: nil, country_id: nil, city_id: nil)
                self.user?.password = self.userPassword.text
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    @IBAction func signUpWithEmail(_ sender: Any) {
        if !self.validateInputs() {
            return
        } else {
            performSegue(withIdentifier: "userSignup", sender: self)
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
        default:
            fatalError("Unexpected Segue Identifier: \(String(describing: segue.identifier))")
        }
    }


}
