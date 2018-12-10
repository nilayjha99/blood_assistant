//
//  SearchAddressViewController.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-09.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit
import MapKit

class SearchAddressViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
   
    
    var matchingItems: [MKMapItem] = []
    var user: UserModel?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.user = UserProfileViewController.passedUser
    }
    
    func parseAddress(_ selectedItem:MKPlacemark) -> String {
        
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil &&
            selectedItem.thoroughfare != nil) ? " " : ""
        
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) &&
            (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil &&
            selectedItem.administrativeArea != nil) ? " " : ""
        
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
    
    func getStreetAddress(_ selectedItem: MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil &&
            selectedItem.thoroughfare != nil) ? " " : ""
        
        return String(format: "%@%@%@",
          // street number
          selectedItem.subThoroughfare ?? "",
          firstSpace,
          // street name
            selectedItem.thoroughfare ?? ""
        )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let selectedItem = matchingItems[(indexPath as NSIndexPath).row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem)
        return cell
    }
    
    func loadLocationSuggestions() {
        let searchBarText = self.searchBar.text!
        

        let centre = CLLocationCoordinate2D(latitude: Constants.pLat, longitude: Constants.pLong)
        let region = MKCoordinateRegion(center: centre, span: Constants.span)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = region
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems.filter {$0.placemark.locality == "Regina"}
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[(indexPath as NSIndexPath).row].placemark
        self.user?.lat = selectedItem.coordinate.latitude
        self.user?.lng = selectedItem.coordinate.longitude
        self.user?.address = self.getStreetAddress(selectedItem)
        UserProfileViewController.passedUser = self.user
        dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            
            view.endEditing(true)
            
            tableView.reloadData()
            
        } else {
            
            inSearchMode = true
            loadLocationSuggestions()
        }
    }
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
