//
//  tabViewController.swift
//  bloodAssitant
//
//  Created by Abhishekkumar Israni on 2018-11-29.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit

class tabViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    @IBOutlet weak var segmentedForHistory: UISegmentedControl!
    @IBOutlet weak var tableViewForSegmented: UITableView!
    
    let donatedTo = ["John" , "Jhonson", "Mike", "Siri", "Tesla" ]
    let receivedFrom = ["Tega" , "Robert", "Anderson", "Sara", "Sam" ]
    override func viewDidLoad() {
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
