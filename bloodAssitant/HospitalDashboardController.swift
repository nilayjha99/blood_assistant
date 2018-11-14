//
//  HospitalDashboardController.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-11-09.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit

class HospitalDashboardController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        GeneralUtils.setBorder(
            viewObject: self.button,
           borderColor: UIColor.black.cgColor,
           borderWidth: 2)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "reauestCard", for: indexPath) as! BloodRequestViewCell
        cell.userThumbnail.setTitle("B", for: .normal)
        GeneralUtils.calculateRadusforCircle(viewObject: cell.userThumbnail)
        cell.userName.text = "John Doe"
        cell.userBloodGroup.text = "AB+"
        cell.requestedUnits.text = "2"
        GeneralUtils.makeRoundCorners(viewObject: cell, radius: 10)

        return cell
    }
    
    
}


