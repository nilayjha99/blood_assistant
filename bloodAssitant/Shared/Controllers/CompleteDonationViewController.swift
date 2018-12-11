//
//  CompleteDonationViewController.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-05.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CompleteDonationViewController: UIViewController {

    //MARK: - variables -
    // view reference for submit Button
    @IBOutlet weak var submitButton: BlackButton!
    // view reference for cancel button
    @IBOutlet weak var cancelButton: BlackButton!
    // view reference for donation code field
    @IBOutlet weak var donationCode: UITextField!
    // view reference for donation reference number field
    @IBOutlet weak var donationReferenceNumber: UITextField!
    
    // MARK: - Overriden Methods -
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions -
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func completeDonationButton(_ sender: Any) {
         let BLOOD_REQUESTS_URL = Constants.BASE_URL + "user/donations/"
        if let dontion_id = Int(self.donationReferenceNumber.text!), let donation_code = Int(self.donationCode.text!) {
            let parameters: Parameters = [
                "code": donation_code,
                "ref_no": dontion_id,
                "donation_id": dontion_id,
                "operation": 3
            ]
            HttpHandler.put(url: BLOOD_REQUESTS_URL, data: parameters, responseHandler: {
                (_, success: Bool) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
}

