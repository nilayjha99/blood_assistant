//
//  HospitalDashboardController.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-11-09.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit

class HospitalDashboardController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
//    
//    @IBOutlet weak var button1: UIButton!
//    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var updateReositoryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        GeneralUtils.setBorder(
            viewObject: self.updateReositoryButton,
            borderColor: self.updateReositoryButton!.tintColor.cgColor,
           borderWidth: 1)
        GeneralUtils.makeRoundCorners(viewObject: self.updateReositoryButton, radius: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "reauestCard", for: indexPath) as! BloodRequestViewCell
        cell.userThumbnail.setTitle("B", for: .normal)
        GeneralUtils.makeItCircle(viewObject: cell.userThumbnail)
        cell.userName.text = "John Doe"
        cell.userBloodGroup.text = "AB+"
        cell.requestedUnits.text = "2"
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


