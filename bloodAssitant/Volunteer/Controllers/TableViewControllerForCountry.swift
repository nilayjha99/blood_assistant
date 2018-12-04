//
//  TableViewControllerForCountry.swift
//  bloodAssitant
//
//  Created by Abhishekkumar Israni on 2018-11-12.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit

class TableViewControllerForCountry: UITableViewController , UISearchResultsUpdating{
    
    

    //Following is the country array for searching from the list
    var Countryarray = ["India","Canada","USA","Pakistan","Afganistan","Australia","Ireland","Albania","Russia","Qatar","Jamaica","South Africa","Maldives","Norway","Oman","Greece","Zambia"]
    
    //var Cityarray = ["Regina","Toronto","Vancouver","saskatoon","moosejaw"]
    
    
    var filteredCountry = [String]()
    var searchController = UISearchController()
    
    var resultsController = UITableViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController: resultsController)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        
        
        resultsController.tableView.delegate = self
        resultsController.tableView.dataSource = self
    
    
    }
    
    // The below function will take only item which contains inside the Countryarray
    func updateSearchResults(for searchController: UISearchController) {
        
        filteredCountry = Countryarray.filter({ (Countryarray:String) -> Bool in
            
             if Countryarray.contains(searchController.searchBar.text!)
            
             {
            return true
             }
            
             else {
            return false
            }
            
            
        })
        resultsController.tableView.reloadData()
        
        
    }

    // MARK: - Table view data source

  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if tableView == resultsController.tableView {
            
            return filteredCountry.count
            
        }
        
        else
        {
            return Countryarray.count
            
        }
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if tableView == resultsController.tableView
        {
            cell.textLabel?.text = filteredCountry[indexPath.row]
        }
        else
        {
            cell.textLabel?.text = Countryarray[indexPath.row]
        }
        return  cell
    }
   

    
    @IBAction func cancelSearch(_ sender: UIBarButtonItem) {
         dismiss(animated: true, completion: nil)
        
        
    }
    
}
