//
//  ViewController.swift
//  bloodAssitant
//
//  Created by Abhishekkumar Israni on 2018-11-09.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func countrySelectButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "TableViewControllerForCountry", sender: self)
    }
}


