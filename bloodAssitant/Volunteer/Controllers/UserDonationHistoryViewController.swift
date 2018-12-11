//
//  tabViewController.swift
//  bloodAssitant
//
//  Created by Abhishekkumar Israni on 2018-11-29.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserDonationHistoryViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    // MARK: - Variables -
    @IBOutlet weak var segmentedForHistory: UISegmentedControl!
    @IBOutlet weak var tableViewForSegmented: UITableView!
    
    var donatedTo = [String]()
    var receivedFrom = [String]()
    var userHistory: JSON?
    
    // MARK: - Overriden Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewForSegmented.delegate = self
        tableViewForSegmented.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        HttpHandler.get(url: Constants.BASE_URL + "user/history/", queryParams: nil, responseHandler: { (json: JSON, success: Bool) in
            if success {
                var donated1 = [String]()
                var received1 = [String]()
                
                let donated = json["donated"]
                for (_,subJson):(String, JSON) in donated {
                   donated1.append("\(subJson["name"])\t\(subJson["date"])")
                }
                let received = json["received"]
                for (_,subJson):(String, JSON) in received {
                    received1.append("\(subJson["name"])\t\(subJson["date"])")
                }
                self.donatedTo = donated1
                self.receivedFrom = received1
                self.tableViewForSegmented.reloadData()
            }
        })
    }
    
    // MARK: - Delegate Methods -
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch segmentedForHistory.selectedSegmentIndex{
            
        case 0:
            return donatedTo.count
        case 1:
            return receivedFrom.count
            
            
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableViewForSegmented.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        
        cell.textLabel?.textAlignment = .center
        switch segmentedForHistory.selectedSegmentIndex{
            
        case 0 :
            cell.textLabel?.text = donatedTo[indexPath.row]
        case 1:
            cell.textLabel?.text = receivedFrom[indexPath.row]
            
        default:
            break
            
        }
        return cell
    }
    
    // MARK: - Action -
    @IBAction func sementedActionOnTouch(_ sender: Any) {
        
        tableViewForSegmented.reloadData()
    }

}
