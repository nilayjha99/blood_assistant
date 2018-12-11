//
//  ShowOnMapViewController.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-10.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit
import MapKit

class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle:String, pinSubTitle:String, location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}

class ShowOnMapViewController: UIViewController, MKMapViewDelegate {
    // MARK: - Variables -
    @IBOutlet weak var mapView: MKMapView!

    static var searchResults = [SearchResultModel]()
    var mapPins = [customPin]()
    
    // MARK: - Overriden Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let centre = CLLocationCoordinate2D(latitude: Constants.pLat, longitude: Constants.pLong)
        let region = MKCoordinateRegion(center: centre, span: Constants.span)
        
        self.mapView.setRegion(region, animated: true)
        self.mapView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if ShowOnMapViewController.searchResults.count > 0 {
            self.makeMarkers()
            self.addMarkers()
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }
    }

    // MARK: - Functions -
    func makeMarkers() {
        var pins = [customPin]()
        for searchResult in ShowOnMapViewController.searchResults {
            var subtitleString: String = String(format: "address:%@\n", searchResult.addres!)
            if searchResult.phone ?? nil != nil {
                subtitleString += String(format: "email:%@\nphone:%@", searchResult.email!, searchResult.phone!)
            }
            let location = CLLocationCoordinate2D(latitude: searchResult.lat!, longitude: searchResult.lng!)
            let pin = customPin(pinTitle: searchResult.name!,
                                pinSubTitle: subtitleString, location: location)
            pins.append(pin)
        }
        self.mapPins = pins
    }

    func addMarkers() {
        for pin in self.mapPins {
            self.mapView.addAnnotation(pin)
        }
    }
    
    // MARK: - Action -
    @IBAction func closeMapView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
