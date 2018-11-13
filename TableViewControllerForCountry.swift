//
//  TableViewControllerForCountry.swift
//  bloodAssitant
//
//  Created by Abhishekkumar Israni on 2018-11-12.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit

class TableViewControllerForCountry: UITableViewController {

    //Following is the country array for searching from the list
    var countryArray = ["India","Canada","USA","Pakistan","Afganistan","Australia","Ireland","Albania","Russia","Qatar","Jamaica","South Africa","Maldives","Norway","Oman","Greece","Zambia"]
    
    var searchController = UISearchController()
    
    var resultsController = UITableViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source

  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         return countryArray.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = countryArray[indexPath.row]
        return cell
    }
   

    

}
