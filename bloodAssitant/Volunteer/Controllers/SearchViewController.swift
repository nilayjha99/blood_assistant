//
//  SearchViewController.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-05.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController {

 
    @IBOutlet weak var bloodGroupField: BorderedTextField!
    var bloodPicker: UIPickerView?
    var selectedBloodGroup: String?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedBloodGroup = "A+"
        self.initBloodPicker()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchButonAction(_ sender: Any) {
        let params: Parameters = [
            "country_id": Constants.COUNTRY_ID,
            "city_id": Constants.CITY_ID,
            "blood_group_id": Constants.BLOOD_GROUPS.firstIndex(of: self.selectedBloodGroup!)! + 1
        ]
        HttpHandler.post(url: Constants.BASE_URL + "blood/search/", data: params, responseHandler: {
            (json: JSON, success: Bool) in
            if success {
                var searchResultsDonors = [SearchResultModel]()
                for (_,subJson):(String, JSON) in json["donors"] {
                    let result = SearchResultModel()
                    result.to_user_id = subJson["user_id"].intValue
                    result.name = subJson["name"].stringValue
                    result.addres = subJson["address"].stringValue
                    result.lat = subJson["address_geo"]["lat"].doubleValue
                    result.lng = subJson["address_geo"]["long"].doubleValue
                    searchResultsDonors.append(result)
                }
                SearchReasultsViewController.searchResultsDonors = searchResultsDonors
                
                var searchResultsHospitals = [SearchResultModel]()
                for (_,subJson):(String, JSON) in json["hospitals"] {
                    let result = SearchResultModel()
                    result.to_user_id = subJson["user_id"].intValue
                    result.name = subJson["name"].stringValue
                    result.addres = subJson["address"].stringValue
                    result.lat = subJson["address_geo"]["lat"].doubleValue
                    result.lng = subJson["address_geo"]["long"].doubleValue
                    result.email = subJson["email"].stringValue
                    result.phone = subJson["phone"].stringValue
                    searchResultsHospitals.append(result)
                }
                SearchReasultsViewController.searchResultHospitals = searchResultsHospitals
                SearchReasultsViewController.bloodGroupId = Constants.BLOOD_GROUPS.firstIndex(of: self.selectedBloodGroup!)! + 1
                self.performSegue(withIdentifier: "searchResults", sender: self)
            }
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
        self.bloodPicker?.delegate = self
        self.bloodPicker?.dataSource = self
        self.bloodGroupField.inputView = self.bloodPicker
        self.bloodGroupField.inputAccessoryView = toolbar
    }
    
    @objc private func bloodPickerDoneTapped() {
        self.bloodGroupField.text = self.selectedBloodGroup
        view.endEditing(true)
    }
   
    // code for custom picker to take input the priority
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
