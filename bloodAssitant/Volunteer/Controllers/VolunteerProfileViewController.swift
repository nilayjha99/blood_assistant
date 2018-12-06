//
//  VolunteerProfileViewController.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-04.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit

class VolunteerProfileViewController: UIViewController {

    @IBOutlet weak var emailField: UILabel!
    @IBOutlet weak var userAddress: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var bloodGroupButton: UIButton!
    var user: UserModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        GeneralUtils.makeItCircle(viewObject: self.bloodGroupButton)
        // Do any additional setup after loading the view.
        self.user = UserModel.loadUser()
        self.userName.text = self.user?.name
        self.userAddress.text = self.user?.address
        self.emailField.text = self.user?.email
        HttpHandler.user_id = Int((user?.user_id)!)!
        HttpHandler.user_role_id = Constants.VOLUNTEER_ROLE_ID
        print(self.user?.getIntegerValue(input: ((self.user?.blood_group_id)!)) ?? "aa")
        
        let initial = Constants.BLOOD_GROUPS[(self.user?.getIntegerValue(input: (self.user?.blood_group_id)!))! - 1 ]
        self.bloodGroupButton.setTitle(initial, for: UIControl.State.normal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.user?.user_token = nil
        UserModel.saveUser(user: self.user!)
    }
}
