//
//  HospitalDashbordViewontroller.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-11-09.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class VolunteerDashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    // MARK: - Variables -
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var completeDonationButton: BlackButton!
    let BLOOD_REQUESTS_URL = Constants.BASE_URL + "user/donations/"
    var blodRequests = [BloodRequestsModel]()
   
    // MARK: - Overriden Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        HttpHandler.get(url: BLOOD_REQUESTS_URL, queryParams: nil, responseHandler: {(json: JSON, success: Bool) in
            
            if success {
                var blodRequests1 = [BloodRequestsModel]()
                for (_, subJson):(String, JSON) in json {
                    print(subJson["units"].intValue)
                    let blood_request = BloodRequestsModel(
                        id: subJson["id"].intValue,
                        to_user_id: subJson["to_user_id"].intValue,
                        units: subJson["units"].intValue,
                        blood_group_name: subJson["blood_group"]["name"].stringValue,
                        blood_group_id: subJson["blood_group"]["id"].intValue,
                        to_user_name: subJson["to_user_name"].stringValue
                    )
                    blood_request.units = subJson["units"].intValue
                    blodRequests1.append(blood_request)
                    
                }
                self.blodRequests = blodRequests1
                self.tableView.reloadData()
               
            }
        })
    }
    
    // MARK: - Delegate Methods -
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.blodRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bloodRequestCellIdentifier", for: indexPath) as! DonationRequestsTableViewCell
        let blood_request = self.blodRequests[indexPath.row]
        cell.nameLabel.text = blood_request.to_user_name
        cell.bloodGroupLabel.text = blood_request.blood_group_name
        print(String(blood_request.units!))
        cell.unitsLabel.text = String(blood_request.units!)
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.showBloodRequestActionsAlert(indexPath: indexPath)
    }
    
    // MARK: - Functions -
    func showBloodRequestActionsAlert(indexPath: IndexPath) {
        let blood_request = self.blodRequests[indexPath.row]
        let alert = UIAlertController(title: "Give Blood",
                                      message: "Would like to give blood to \(blood_request.to_user_name!)",
            preferredStyle: .alert)
        var requestParameters: Parameters = [
            "donation_id" : blood_request.id!
        ]
        let acceptAction = UIAlertAction(title: "Yes", style: .default, handler: {(_) in
                requestParameters["operation"] = 1
            HttpHandler.put(url: self.BLOOD_REQUESTS_URL, data: requestParameters, responseHandler: {
                (_, success: Bool) in
                self.blodRequests.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.reloadData()
            })
        })
        let rejectAction = UIAlertAction(title: "No", style: .default, handler: {(_) in
            requestParameters["operation"] = 2
            HttpHandler.put(url: self.BLOOD_REQUESTS_URL, data: requestParameters, responseHandler: {
                (_, success: Bool) in
                self.blodRequests.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.reloadData()
            })
        })
        
        alert.addAction(acceptAction)
        alert.addAction(rejectAction)
        present(alert, animated: true)
    }
    
}
