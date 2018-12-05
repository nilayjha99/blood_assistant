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

class VolunteerDashboardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var completeDonationButton: BlackButton!
    @IBOutlet weak var collectionView: UICollectionView!
    let BLOOD_REQUESTS_URL = Constants.BASE_URL + "user/dontions/"
    var blodRequests = [BloodRequestsModel]()
    override func viewDidLoad() {
        HttpHandler.get(url: BLOOD_REQUESTS_URL, queryParams: nil, responseHandler: {(json: JSON, success: Bool) in
            if success {
                for (_, subJson):(String, JSON) in json {
                    let blood_request = BloodRequestsModel(
                        id: subJson["id"].intValue,
                        to_user_id: subJson["to_user_id"].intValue,
                        units: subJson["units"].intValue,
                        blood_group_name: subJson["blod_group"]["blood_group_name"].stringValue,
                        blood_group_id: subJson["blood_group"]["blood_group_id"].intValue,
                        to_user_name: subJson["to_user_name"].stringValue
                        )
                    self.blodRequests.append(blood_request)
                }
            }
        })
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.blodRequests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "reauestCard", for: indexPath) as! BloodRequestViewCell
        let blood_request = self.blodRequests[indexPath.row]
        cell.userThumbnail.setTitle(String((blood_request.to_user_name?.first)!), for: .normal)
        GeneralUtils.makeItCircle(viewObject: cell.userThumbnail)
        cell.userName.text = blood_request.to_user_name
        cell.userBloodGroup.text = blood_request.blood_group_name
        cell.requestedUnits.text = String(blood_request.units!)
        GeneralUtils.makeRoundCorners(viewObject: cell, radius: 10)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.showAlert(indexPath: indexPath)
    }
    
    func showAlert(indexPath: IndexPath) {
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
                self.collectionView.deleteItems(at: [indexPath])
                self.collectionView.reloadData()
            })
        })
        let rejectAction = UIAlertAction(title: "No", style: .default, handler: {(_) in
            requestParameters["operation"] = 2
            HttpHandler.put(url: self.BLOOD_REQUESTS_URL, data: requestParameters, responseHandler: {
                (_, success: Bool) in
                self.blodRequests.remove(at: indexPath.row)
                self.collectionView.deleteItems(at: [indexPath])
                self.collectionView.reloadData()
            })
        })
        
        alert.addAction(acceptAction)
        alert.addAction(rejectAction)
        present(alert, animated: true)
    }
    
}
