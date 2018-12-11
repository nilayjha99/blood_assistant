//
//  ViewController.swift
//  bloodAssitant
//
//  Created by Abhishekkumar Israni on 2018-11-09.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class UserProfileViewController: UIViewController, UITextFieldDelegate  {

    
    @IBOutlet weak var emailField: BorderedTextField!
    @IBOutlet weak var userAddresField: BorderedTextField!
    @IBOutlet weak var userNameField: BorderedTextField!
    @IBOutlet weak var genderField: BorderedTextField!
    @IBOutlet weak var bloodGroupField: BorderedTextField!
  
    static var passedUser: UserModel?
    var user: UserModel?
    static var isEdit = false
    static var isSso = false
    var selectedBloodGroup: String = "A+"
    var selectedGender: String = "male"
    
   // @IBOutlet weak var datePickerTF: UITextField!
    
   // let datePicker = UIDatePicker()
    private var bloodPicker: UIPickerView?
    private var genderPicker: UIPickerView?
    
    override func viewDidLoad() {
        if UserProfileViewController.passedUser != nil {
            self.user = UserProfileViewController.passedUser
            self.loadData()
        }
        super.viewDidLoad()
        self.initBloodPicker()
        self.initGenderPicker()
        self.userAddresField.delegate = self
//        self.loadData()
        // Do any additional setup after loading the view, typically from a nib.
       // dateForAppointment ()
        
      //Use of unresolved identifier 'Cityarray'
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserProfileViewController.passedUser != nil {
            self.user = UserProfileViewController.passedUser
            self.loadData()
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        DispatchQueue.main.async() {
            self.performSegue(withIdentifier: "addAddress", sender: self)
        }
        return false
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func loadData() {
        self.emailField.text = self.user?.email
        if self.user?.name != nil {
            self.userNameField.text = self.user?.name
        }
        if self.user?.address != nil {
            self.userAddresField.text = self.user?.address
        }
        if self.user?.blood_group_id != nil {
            self.bloodGroupField.text = Constants.BLOOD_GROUPS[(self.user?.blood_group_id)! - 1]
        }
        if self.user?.gender != nil {
            self.genderField.text = self.user?.gender
        }
    }
    
    private func handleSignUpResponse(json: JSON, parameters: Parameters?) {
        if !UserProfileViewController.isEdit {
            self.user?.user_id = json["id"].intValue
            self.user?.country_id = json["country_id"].intValue
            self.user?.city_id = json["city_id"].intValue
            self.user?.user_token = json["auth_token"].stringValue
            self.user?.name = json["name"].stringValue
            self.user?.address = json["address"].stringValue
            HttpHandler.user_role_id = Constants.VOLUNTEER_ROLE_ID
            HttpHandler.user_id = json["id"].intValue
            HttpHandler.user_token = json["auth_token"].stringValue
            HttpHandler.initAdapter()
            UserModel.saveUser(user: self.user!)
            self.performSegue(withIdentifier: "newUserSignup", sender: self)
        } else {
            self.user?.name = (parameters!["name"] as! String)
            self.user?.blood_group_id = (parameters!["blood_group_id"] as! Int)
            self.user?.gender = (parameters!["gender"] as! String)
            self.user?.address = (parameters!["address"] as! String)
            self.user?.email = (parameters!["email"] as! String)
            UserModel.saveUser(user: self.user!)
            self.dismiss(animated: true, completion: nil)
        }
       
    }
    
    private func signUpWithEmail(parameters: Parameters) {
        HttpHandler.post(url: Constants.BASE_URL + "signup/with/email/", data: parameters, responseHandler: {
            (json: JSON, success: Bool) in
            if success {
                self.handleSignUpResponse(json: json, parameters: nil)
            }
        })
    }
    
    private func signUpWithFacebook(parameters: Parameters) {
        HttpHandler.post(url: Constants.BASE_URL + "login/with/fb/", data: parameters, responseHandler: {
            (json: JSON, success: Bool) in
            if success {
                self.handleSignUpResponse(json: json, parameters: nil)
            }
        })
    }
    
    private func updateUserProfile(parameters: Parameters) {
        HttpHandler.put(url: Constants.BASE_URL + "user/update/profile/", data: parameters, responseHandler: {
            (json: JSON, success: Bool) in
            if success {
                self.handleSignUpResponse(json: json, parameters: parameters)
            }
        })
    }
    
    @IBAction func saveUserProfile(_ sender: UIBarButtonItem) {
//        user?.lat = 50.41902
//        user?.lng = -104.59144
        var parameters: Parameters = [
            "name": (self.userNameField.text)!,
            "gender": (self.genderField.text)!,
            "email": (self.emailField.text)!,
            "address": (self.userAddresField.text)!,
            "country": Constants.COUNTRY_NAME,
            "city": Constants.CITY_NAME,
            "blood_group_id": Int((user?.blood_group_id)!),
            "user_role_id" : Constants.VOLUNTEER_ROLE_ID,
            "address_geo": [
                "lat": (user?.lat)!,
                "long": (user?.lng)!
            ]
        ]
        if !UserProfileViewController.isEdit {
             parameters["password"] = (user?.password)!
            if !UserProfileViewController.isSso {
              self.signUpWithEmail(parameters: parameters)
            } else {
              parameters["fb_user_id"] = self.user?.fb_user_id
              parameters["fb_access_token"] = self.user?.fb_access_token
              self.signUpWithFacebook(parameters: parameters)
            }
        } else {
            self.updateUserProfile(parameters: parameters)
        }
    }
}

extension UserProfileViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    // code for priority picker
    private func initBloodPicker() {
        // code for toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // add done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(bloodPickerDoneTapped))
        toolbar.setItems([doneButton], animated: true)
        
        
        // code to handle priority input
        self.bloodPicker = UIPickerView()
        self.bloodPicker!.tag = 1
        self.bloodPicker?.delegate = self
        self.bloodPicker?.dataSource = self
        self.bloodGroupField.inputView = self.bloodPicker
        self.bloodGroupField.inputAccessoryView = toolbar
    }
    
    @objc private func bloodPickerDoneTapped() {
        self.bloodGroupField.text = self.selectedBloodGroup
        user?.blood_group_id = Constants.BLOOD_GROUPS.firstIndex(of: self.selectedBloodGroup)! + 1
        view.endEditing(true)
    }
    // code for priority picker
    private func initGenderPicker() {
        // code for toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // add done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(genderPickerDoneTapped))
        toolbar.setItems([doneButton], animated: true)
        
        
        // code to handle priority input
        self.genderPicker = UIPickerView()
        self.genderPicker!.tag = 2
        self.genderPicker?.delegate = self
        self.genderPicker?.dataSource = self
        self.genderField.inputView = self.genderPicker
        self.genderField.inputAccessoryView = toolbar
    }
    @objc private func genderPickerDoneTapped() {
        self.genderField.text = self.selectedGender
        user?.gender = self.selectedGender
        view.endEditing(true)
    }
    
    // code for custom picker to take input the priority
    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return Constants.BLOOD_GROUPS.count
        } else {
            return Constants.GENDERS.count
        }
    }
    
    // returns the selected input and sets it into the textfield
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
        self.selectedBloodGroup =  Constants.BLOOD_GROUPS[row]
        } else {
            self.selectedGender = Constants.GENDERS[row]
        }
    }
    
    // set the appereance of the "lables" on the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
        return Constants.BLOOD_GROUPS[row]
        } else {
           return Constants.GENDERS[row]
        }
    }
    
    //MARK: - Navigation -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "newUserSignup":
            UserProfileViewController.passedUser = self.user
        case "addAddress":
            // check the segue's destination
            UserProfileViewController.passedUser = self.user
        default:
            fatalError("Unexpected Segue Identifier: \(String(describing: segue.identifier))")
        }
    }
}


