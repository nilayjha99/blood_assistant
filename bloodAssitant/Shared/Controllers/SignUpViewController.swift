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

    @IBAction func signUpWithEmail(_ sender: Any) {
        
    }
}
