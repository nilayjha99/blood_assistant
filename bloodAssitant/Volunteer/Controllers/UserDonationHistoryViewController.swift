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
    
    
    
    
    @IBOutlet weak var segmentedForHistory: UISegmentedControl!
    @IBOutlet weak var tableViewForSegmented: UITableView!
    
    var donatedTo = [String]()
    var receivedFrom = [String]()
    
    var userHistory: JSON?
    override func viewDidLoad() {
        HttpHandler.get(url: Constants.BASE_URL + "user/history/", queryParams: nil, responseHandler: { (json: JSON, success: Bool) in
            if success {
                let donated = json["donated"]
                for (_,subJson):(String, JSON) in donated {
                    self.donatedTo.append("\(subJson["name"])\t\(subJson["date"])")
                }
                let received = json["received"]
                for (_,subJson):(String, JSON) in received {
                    self.receivedFrom.append("\(subJson["name"])\t\(subJson["date"])")
                }
            }
        })
        super.viewDidLoad()
     
          tableViewForSegmented.delegate = self
          tableViewForSegmented.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    
    
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
    
    
    
    @IBAction func sementedActionOnTouch(_ sender: Any) {
        
        tableViewForSegmented.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
