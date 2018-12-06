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

    @IBOutlet weak var submitButton: BlackButton!
    @IBOutlet weak var cancelButton: BlackButton!
    @IBOutlet weak var donationCode: UITextField!
    @IBOutlet weak var donationReferenceNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
