//
//  TableViewControllerForCity.swift
//  bloodAssitant
//
//  Created by Abhishekkumar Israni on 2018-11-13.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit

class TableViewControllerForCity: UITableViewController , UISearchResultsUpdating{
    
    
    
   // var myIndex = 0
    var Cityarray = ["Regina","Toronto","Vancouver","saskatoon","moosejaw"]
    var selectedValue: String?
    
    var filteredCity = [String]()
    var searchController = UISearchController()
    
    var resultsController = UITableViewController()
    
    var user: UserModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController: resultsController)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        
        
        resultsController.tableView.delegate = self
        resultsController.tableView.dataSource = self
        
        
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filteredCity = Cityarray.filter({ (Cityarray:String) -> Bool in
            
            if Cityarray.contains(searchController.searchBar.text!)
                
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
            
            return filteredCity.count
            
        }
            
        else
        {
            return Cityarray.count
            
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell =  tableView.dequeueReusableCell(withIdentifier: "simpleCell" , for: indexPath) as! SimpleTableViewCell
        
        if tableView == resultsController.tableView
        {
            cell.itemLabel?.text = filteredCity[indexPath.row]
            
            //citySelect  = (cell.textLabel?.text)!
        }
        else
        {
            cell.itemLabel?.text = Cityarray[indexPath.row]
//            citySelect  = (cell.textLabel?.text)!
            
        }
        return  cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedValue = self.Cityarray[indexPath.row]
        self.user?.city_id = SharedValues.getItemId(name: self.selectedValue!, collection: SharedValues.countries)
            self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelSearchForCity(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
        
        
    }
    
    
  /*  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "ViewController", sender: self)
    }*/
    
    
    
}
