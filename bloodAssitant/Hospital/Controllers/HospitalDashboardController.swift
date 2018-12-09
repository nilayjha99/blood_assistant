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
    
    @IBOutlet weak var abnCell: RepositoryViewCell!
    @IBOutlet weak var abpCell: RepositoryViewCell!
    @IBOutlet weak var onCell: RepositoryViewCell!
    @IBOutlet weak var opCell: RepositoryViewCell!
    @IBOutlet weak var bnCell: RepositoryViewCell!
    @IBOutlet weak var bpCell: RepositoryViewCell!
    @IBOutlet weak var anCell: RepositoryViewCell!
    @IBOutlet weak var apCell: RepositoryViewCell!
    @IBOutlet weak var completeDonationButton: UIButton!
    @IBOutlet weak var updateReositoryButton: UIButton!
    
    let BLOOD_REQUESTS_URL = Constants.BASE_URL + "user/donations/"
    
    var blodRequests = [BloodRequestsModel]()
    var bloodRepositoryDetails = [BloodRepositoryModel]()
    
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
        GeneralUtils.makeRoundCorners(viewObject: self.completeDonationButton, radius: 16)
    }
    
    override func viewWillAppear(_ animated: Bool) {
      self.loadDonationRequests()
      self.loadBloodRepository()
    }
    
    func setCellValue(cell: UIButton, units: Int) {
        cell.setTitle(String(units), for: UIControl.State.normal)
    }
    
    func populateRepoView(blood_repo_info: BloodRepositoryModel) {
        let blood_group_name = Constants.BLOOD_GROUPS[blood_repo_info.blood_group_id! - 1]
        switch (blood_group_name) {
        case "A+":
            self.setCellValue(cell: self.apCell, units: blood_repo_info.blood_units!)
        case "A-":
            self.setCellValue(cell: self.anCell, units: blood_repo_info.blood_units!)
        case "B+":
            self.setCellValue(cell: self.bpCell, units: blood_repo_info.blood_units!)
        case "B-":
            self.setCellValue(cell: self.bnCell, units: blood_repo_info.blood_units!)
        case "O+":
            self.setCellValue(cell: self.opCell, units: blood_repo_info.blood_units!)
        case "O-":
            self.setCellValue(cell: self.onCell, units: blood_repo_info.blood_units!)
        case "AB+":
            self.setCellValue(cell: self.abpCell, units: blood_repo_info.blood_units!)
        case "AB-":
            self.setCellValue(cell: self.abnCell, units: blood_repo_info.blood_units!)
        default:
            fatalError("Unknown value")
        }
    }
    
    func loadBloodRepository() {
        HttpHandler.get(url: Constants.BASE_URL + "repository/\(String(HttpHandler.user_id!))/", queryParams: nil, responseHandler: {(json: JSON, success: Bool) in
            
            if success {
                var bloodRepoLocal = [BloodRepositoryModel]()
                for (_, subJson):(String, JSON) in json {
                    let blood_repo = BloodRepositoryModel(blood_group_id: subJson["blood_group_id"].intValue, blood_repo_id: subJson["id"].intValue, blood_units: subJson["units"].intValue)
                    bloodRepoLocal.append(blood_repo)
                    self.populateRepoView(blood_repo_info: blood_repo)
                }
                self.bloodRepositoryDetails = bloodRepoLocal
            }
        })
    }
    
    func loadDonationRequests() {
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


