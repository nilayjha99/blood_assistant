//
//  ViewController.swift
//  bloodAssitant
//
//  Created by Abhishekkumar Israni on 2018-11-09.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit


class UserProfileViewController: UIViewController  {

    
    
    
    
   // @IBOutlet weak var datePickerTF: UITextField!
    
   // let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // dateForAppointment ()
        
      //Use of unresolved identifier 'Cityarray'
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


