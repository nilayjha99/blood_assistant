//
//  HospitalDashboardController.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-11-09.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HospitalDashboardController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
//    
//    @IBOutlet weak var button1: UIButton!
//    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var completeDonationButton: UIButton!
    @IBOutlet weak var updateReositoryButton: UIButton!
    
    let BLOOD_REQUESTS_URL = Constants.BASE_URL + "user/donations/"
    
    var blodRequests = [BloodRequestsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        GeneralUtils.setBorder(
            viewObject: self.updateReositoryButton,
            borderColor: self.updateReositoryButton!.tintColor.cgColor,
           borderWidth: 1)
        GeneralUtils.makeRoundCorners(viewObject: self.updateReositoryButton, radius: 10)
        GeneralUtils.setBorder(
            viewObject: self.completeDonationButton,
            borderColor: self.completeDonationButton!.tintColor.cgColor,
            borderWidth: 1)
        GeneralUtils.makeRoundCorners(viewObject: self.completeDonationButton, radius: 10)
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
                self.collectionView.reloadData()
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return blodRequests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "reauestCard", for: indexPath) as! BloodRequestViewCell
        let currentRequest = self.blodRequests[indexPath.row]
        cell.userThumbnail.setTitle("B", for: .normal)
        GeneralUtils.makeItCircle(viewObject: cell.userThumbnail)
        cell.userName.text = currentRequest.to_user_name
        cell.userBloodGroup.text = currentRequest.blood_group_name
        cell.requestedUnits.text = String(currentRequest.units!)
        
        GeneralUtils.makeRoundCorners(viewObject: cell, radius: 10)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.showAlert(indexPath: indexPath)
    }
    
    func showAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Give Blood",
                                      message: "give blood to \(indexPath.row)",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil);
        alert.addAction(action)
        present(alert, animated: true)
    }
}


