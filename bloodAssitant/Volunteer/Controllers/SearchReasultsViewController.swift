//
//  SearchReasultsViewController.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-06.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit
import Alamofire

class SearchReasultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Variables -
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    static var searchResultsDonors = [SearchResultModel]()
    static var searchResultHospitals = [SearchResultModel]()
    static var bloodGroupId: Int?
    
    // MARK: - Overriden Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        ShowOnMapViewController.searchResults = SearchReasultsViewController.searchResultsDonors
        // Do any additional setup after loading the view.
    }

    // MARK: - Delegate Methods -
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch segmentedControl.selectedSegmentIndex{
            
        case 0:
            return SearchReasultsViewController.searchResultsDonors.count
        case 1:
            return SearchReasultsViewController.searchResultHospitals.count
            
            
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Ask for blood!", message: "Enter the number of units you want.", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {(textfield) in
            textfield.placeholder = "1 unit is 300 ml"
            textfield.textAlignment = .center
        })
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: {(_) in
            let units = Int(alert.textFields![0].text!)
            let to_user_id = (self.segmentedControl.selectedSegmentIndex > 0) ? SearchReasultsViewController.searchResultHospitals[indexPath.row].to_user_id : SearchReasultsViewController.searchResultsDonors[indexPath.row].to_user_id
            let params: Parameters = [
                "from_user_id": HttpHandler.user_id!,
                "to_user_id": to_user_id!,
                "units": units!,
                "blood_group_id": SearchReasultsViewController.bloodGroupId!
            ]
            HttpHandler.post(url: Constants.BASE_URL + "user/donations/", data: params, responseHandler: {(_, success) in
                if success {
                    print("done")
                }
            })
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "searchResultCell" , for: indexPath) as! SearchReasultTableViewCell
        
        
        switch self.segmentedControl.selectedSegmentIndex{
            
        case 0 :
            cell.nameLabel?.text = SearchReasultsViewController.searchResultsDonors[indexPath.row].name
        case 1:
            cell.nameLabel?.text = SearchReasultsViewController.searchResultHospitals[indexPath.row].name
            
        default:
            break
            
        }
        return cell
    }
    
    // MARK: - Action -
    @IBAction func onSegmentChange(_ sender: Any) {
        self.tableView.reloadData()
        switch self.segmentedControl.selectedSegmentIndex{
            
        case 0 :
            ShowOnMapViewController.searchResults = SearchReasultsViewController.searchResultsDonors
        case 1:
            ShowOnMapViewController.searchResults = SearchReasultsViewController.searchResultHospitals
        default:
            break
            
        }
    }
    
}
