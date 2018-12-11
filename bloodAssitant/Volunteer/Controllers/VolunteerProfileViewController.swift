//
//  VolunteerProfileViewController.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-04.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit

class VolunteerProfileViewController: UIViewController {

     // MARK: - Variables -
    @IBOutlet weak var emailField: UILabel!
    @IBOutlet weak var userAddress: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var bloodGroupButton: UIButton!
    var user: UserModel?
    
    // MARK: - Overriden Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserProfileViewController.isEdit = false
        UserProfileViewController.isSso = false
        GeneralUtils.makeItCircle(viewObject: self.bloodGroupButton)
        // Do any additional setup after loading the view.
        self.user = UserModel.loadUser()
        self.userName.text = self.user?.name
        self.userAddress.text = self.user?.address
        self.emailField.text = self.user?.email
        HttpHandler.user_id = (user?.user_id)!
        HttpHandler.user_role_id = Constants.VOLUNTEER_ROLE_ID
        
        let initial = Constants.BLOOD_GROUPS[(self.user?.blood_group_id)! - 1 ]
        self.bloodGroupButton.setTitle(initial, for: UIControl.State.normal)
        
    }
    
    //MARK: - Navigation -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "editProfile":
            UserProfileViewController.passedUser = self.user
            UserProfileViewController.isEdit = true
        case "volunteerLogout":
            self.user?.user_token = nil
            UserModel.saveUser(user: self.user!)
        default:
            fatalError("Unexpected Segue Identifier: \(String(describing: segue.identifier))")
        }
    }
}
