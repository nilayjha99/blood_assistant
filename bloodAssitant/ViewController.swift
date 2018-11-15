//
//  ViewController.swift
//  bloodAssitant
//
//  Created by Abhishekkumar Israni on 2018-11-09.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
   
    @IBOutlet weak var citySelectInProfile: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
       citySelectInProfile.titleLabel.text = Cityarray[IndexPath]
        
    }


    @IBAction func countrySelectButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "TableViewControllerForCountry", sender: self)
    }
    
    
    @IBAction func citySelectButton(_ sender: Any) {
        self.performSegue(withIdentifier: "TableViewControllerForCity", sender: self)
    }
    
}


