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

    
    
    
    
   // @IBOutlet weak var datePickerTF: UITextField!
    
   // let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        // Do any additional setup after loading the view, typically from a nib.
       // dateForAppointment ()
        
      //Use of unresolved identifier 'Cityarray'
    }
    
    func loadData(){
        let parameters: Parameters = [
            "email": "nilay@yopmail.com",
            "password": "123456",
            "user_role_id": 1
        ]
        HttpHandler.post(url: "https://3344f8bb.ngrok.io/api/v1/login/with/email/", data: parameters, responseHandler: showUserProfile)
    }
    func showUserProfile(json: JSON) {
        print(json.isEmpty)
    }
    @IBAction func countrySelectButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "TableViewControllerForCountry", sender: self)
    }
    
    
    @IBAction func citySelectButton(_ sender: Any) {
        self.performSegue(withIdentifier: "TableViewControllerForCity", sender: self)
    }
    
    
    //func dateForAppointment () {
    ///datePickerTF.inputView = datePicker
   
    
    //Create tool bar for apointment selection date picker
        
      //  let toolBar = UIToolbar()
      //  toolBar.sizeToFit()
        
        //add a done button
       // let doneButton = UIBarButtonItem(barButtonSystemItem: .done , target: nil , action: #selector(doneClicked))
        
        //let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel , target: nil , action: nil)
       
        //toolBar.setItems([doneButton], animated: true)
        //datePickerTF.inputAccessoryView = toolBar
        
        
    //}
    ///@objc func doneClicked(){
        
      //  datePickerTF.text = "\(datePicker.date)"
      //  self.view.endEditing(true)
    
   // }
    

}


