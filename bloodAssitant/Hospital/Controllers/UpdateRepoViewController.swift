//
//  UpdateRepoViewController.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-09.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit
import Alamofire

class UpdateRepoViewController: UIViewController {

    // MARK: - Variables -
    var bloodRepo = [BloodRepositoryModel]()
    var selectedBloodGroup: String = "A+"
    private var bloodPicker: UIPickerView?
    
    @IBOutlet weak var unitsField: BorderedTextField!
    @IBOutlet weak var bloodGroupField: BorderedTextField!
    
    // MARK: - Overriden Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initBloodPicker()
    }
    
    // MARK: - Functions -
    func getRepoId(blood_group_name: String) -> Int {
        let blood_group_id = Constants.BLOOD_GROUPS.firstIndex(of: self.bloodGroupField.text!)! + 1
        let blood_repo_id = self.bloodRepo.filter {$0.blood_group_id == blood_group_id}
        return blood_repo_id[0].blood_repo_id!
    }
    
    // MARK: - Action -
    @IBAction func updateRepo(_ sender: Any) {
        let parameters: Parameters = [
            "units": Int(self.unitsField.text!)!
        ]
        HttpHandler.put(url: Constants.BASE_URL + "repository/\(self.getRepoId(blood_group_name: self.bloodGroupField.text!))/", data: parameters, responseHandler: {(_, success: Bool) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Extension -
extension UpdateRepoViewController: UIPickerViewDataSource, UIPickerViewDelegate {
  
    // code for blood group picker
    private func initBloodPicker() {
        // code for toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // add done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(bloodPickerDoneTapped))
        toolbar.setItems([doneButton], animated: true)
        
        
        // code to handle blood group input
        self.bloodPicker = UIPickerView()
        self.bloodPicker?.delegate = self
        self.bloodPicker?.dataSource = self
        self.bloodGroupField.inputView = self.bloodPicker
        self.bloodGroupField.inputAccessoryView = toolbar
    }
    
    @objc private func bloodPickerDoneTapped() {
        self.bloodGroupField.text = self.selectedBloodGroup
        view.endEditing(true)
    }
    
    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.BLOOD_GROUPS.count
    }
    
    // returns the selected input and sets it into the textfield
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedBloodGroup = Constants.BLOOD_GROUPS[row]
        
    }
    
    // set the appereance of the "lables" on the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constants.BLOOD_GROUPS[row]
    }
}

