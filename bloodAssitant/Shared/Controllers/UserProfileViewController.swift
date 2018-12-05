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

    
    @IBOutlet weak var cityButton: BlackButton!
    @IBOutlet weak var countryButton: BlackButton!
    var user: UserModel?
    var isEdit = false
    
   // @IBOutlet weak var datePickerTF: UITextField!
    
   // let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.manageCityCountrySeletors()
//        self.loadData()
        // Do any additional setup after loading the view, typically from a nib.
       // dateForAppointment ()
        
      //Use of unresolved identifier 'Cityarray'
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.manageCityCountrySeletors()
    }
    
    func manageCityCountrySeletors() {
        if let userDetails = user {
            if isEdit{
                let user_country = SharedValues.getItemName(id: userDetails.country_id!,
                                                            collection: SharedValues.countries)
                self.countryButton.setTitle(user_country, for: UIControl.State.normal)
                if SharedValues.cities != nil {
                    let user_city = SharedValues.getItemName(id: userDetails.city_id!, collection: SharedValues.cities)
                    self.cityButton.setTitle(user_city, for: UIControl.State.normal)
                    self.cityButton.isEnabled = true
                } else {
                    print("error in setting user city")
                }
                
            } else {
                self.cityButton.isEnabled = false
            }
            
        }
    }
    @IBAction func countrySelectButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "TableViewControllerForCountry", sender: self)
    }
    
    
    @IBAction func citySelectButton(_ sender: Any) {
        self.performSegue(withIdentifier: "TableViewControllerForCity", sender: self)
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "TableViewControllerForCountry":
            // check the segue's destination
            guard let countryViewController = segue.destination as? TableViewControllerForCountry else {
                fatalError("unexpected destination: \(segue.destination)")
                }
            countryViewController.Countryarray = SharedValues.countryNames
            countryViewController.user = self.user
            
        case "TableViewControllerForCity":
            
            // cast sender of segue to MealTableView and if sender has error rise xception
            guard let cityViewController = sender as? TableViewControllerForCity else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            cityViewController.Cityarray = SharedValues.cityNames
            cityViewController.user = self.user
            
        default:
            fatalError("Unexpected Segue Identifier: \(String(describing: segue.identifier))")
        }
    }

    @IBAction func saveUserProfile(_ sender: UIBarButtonItem) {
        
    }
    /// It is a reverse seague handler which edits existing meal details or adds a new cell to tale view for a new meal.


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


