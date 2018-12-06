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

class UserProfileViewController: UIViewController  {

    
    @IBOutlet weak var userAddresField: BorderedTextField!
    @IBOutlet weak var userNameField: BorderedTextField!
    @IBOutlet weak var genderField: BorderedTextField!
    @IBOutlet weak var bloodGroupField: BorderedTextField!
    @IBOutlet weak var cityButton: BlackButton!
    @IBOutlet weak var countryButton: BlackButton!
    static var passedUser: UserModel?
    var user: UserModel?
    var isEdit = false
    var isSso = false
    var selectedBloodGroup: String?
    var selectedGender: String?
    
   // @IBOutlet weak var datePickerTF: UITextField!
    
   // let datePicker = UIDatePicker()
    private var bloodPicker: UIPickerView?
    private var genderPicker: UIPickerView?
    
    override func viewDidLoad() {
        if UserProfileViewController.passedUser != nil {
            self.user = UserProfileViewController.passedUser
        }
        super.viewDidLoad()
        self.initBloodPicker()
        self.initGenderPicker()

//        self.loadData()
        // Do any additional setup after loading the view, typically from a nib.
       // dateForAppointment ()
        
      //Use of unresolved identifier 'Cityarray'
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
  
    @IBAction func countrySelectButton(_ sender: Any) {
        
//        self.performSegue(withIdentifier: "TableViewControllerForCountry", sender: self)
    }
    
    
    @IBAction func citySelectButton(_ sender: Any) {
//        self.performSegue(withIdentifier: "TableViewControllerForCity", sender: self)
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveUserProfile(_ sender: UIBarButtonItem) {
        user?.lat = 15.222
        user?.lng = -15.585
        let parameters: Parameters = [
            "name": (self.userNameField.text)!,
            "gender": (self.genderField.text)!,
            "email": (user?.email)!,
            "address": (self.userAddresField.text)!,
            "country": (self.countryButton.currentTitle)!,
            "city": (self.cityButton.currentTitle)!,
            "blood_group": Int((user?.blood_group_id)!)!,
            "user_role_id" : Constants.VOLUNTEER_ROLE_ID,
            "password": (user?.password)!,
            "address_geo": [
                "lat": (user?.lat)!,
                "long": (user?.lng)!
            ]
        ]
        if !isEdit {
            if !isSso {
                HttpHandler.post(url: Constants.BASE_URL + "signup/with/email/", data: parameters, responseHandler: {
                    (json: JSON, success: Bool) in
                    if success {
                        self.user?.user_id = String(json["id"].intValue)
                        self.user?.country_id = json["country_id"].intValue
                        self.user?.city_id = json["city_id"].intValue
                        self.user?.user_token = json["auth_token"].stringValue
                        HttpHandler.user_role_id = Constants.VOLUNTEER_ROLE_ID
                        HttpHandler.user_id = json["id"].intValue
                        HttpHandler.user_token = json["auth_token"].stringValue
                        HttpHandler.initAdapter()
                        UserModel.saveUser(user: self.user!)
                    }
                })
            }
        } else {
            
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
        user?.blood_group_id = String(Constants.BLOOD_GROUPS.firstIndex(of: self.selectedBloodGroup!)! + 1)
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
}


