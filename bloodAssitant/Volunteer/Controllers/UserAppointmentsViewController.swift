//
//  UserAppointmentsViewController.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-03.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit
import Alamofire

class UserAppointmentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var addAppointmentButton: UIBarButtonItem!
    
    var userAppointments: [VolunteerAppointments] = []
    var user: UserModel?
    @IBOutlet weak var appointmentsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addAppointmentButton.isEnabled = false
        self.appointmentsTableView.delegate = self
        self.appointmentsTableView.dataSource = self
        user = UserModel.loadUser()
        SharedValues.lodHospitals(country_id: (self.user?.country_id)!, city_id: (self.user?.city_id)!, handler: {() in
            self.addAppointmentButton.isEnabled = true
        })
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userAppointments.count
    }
    // MARK: - Table view data source -
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdntifier = "userAppointmentsCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdntifier, for: indexPath) as? UserAppointmentsTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        let date = dateFormatter.date(from: self.userAppointments[indexPath.row].date!)
        self.userAppointments[indexPath.row].date = dateFormatter.string(from: date!)
        
        cell.appointmentDate.text = self.userAppointments[indexPath.row].date
        cell.hospitalName.text = self.userAppointments[indexPath.row].hospital_name
        return cell
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let appointment_id = self.userAppointments[indexPath.row].id
            HttpHandler.get(url: Constants.BASE_URL + "appointments/" + String(appointment_id!) + "/update/?op=1", queryParams: nil, responseHandler: {(_, success: Bool) in
                if success {
                    tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
                }
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "addAppointment":
            SharedValues.lodHospitals(country_id: (self.user?.country_id)!, city_id: (self.user?.city_id)!, handler: nil)
        default:
            fatalError("Unexpected Segue Identifier: \(String(describing: segue.identifier))")
        }
    }
    
    // MARK: - Actions -
    /// It is a reverse seague handler which edits existing meal details or adds a new cell to tale view for a new meal.
    @IBAction func unwindToMealList(_ sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddAppointmentViewController, let appointment = sourceViewController.appointment {
            
//            if let selectedIndexPath = .indexPathForSelectedRow {
//                // Update an existing meal.
//                meals[selectedIndexPath.row] = meal
//                tableView.reloadRows(at: [selectedIndexPath], with: .none)
//            } else {
//                // Add a new meal.i
                // this code computes the location of newer cell where new meal is to be inserted
    
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "%Y-%m-%dT%H:%M:%S"
//            let date = dateFormatter.date(from: appointment.date!)
//            appointment.date = dateFormatter.string(from: date!)
            
            let data: Parameters = [
                "hospital_id": appointment.hospital_id!,
                "appointment_date": appointment.date!
            ]
            // Save the meals.
            HttpHandler.post(url: Constants.BASE_URL + "appointments/", data: data, responseHandler: {(_, success: Bool) in
                if success {
                    let newIndexPath = IndexPath(row: self.userAppointments.count, section: 0)
                    
                    self.userAppointments.append(appointment)
                    // .automatic allows the system to decide which animation
                    self.appointmentsTableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            })
        }
    }


}
