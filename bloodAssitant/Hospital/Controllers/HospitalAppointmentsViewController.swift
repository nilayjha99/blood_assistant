//
//  HospitalAppointmentsViewController.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-11-15.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HospitalAppointmentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var appointsTableView: UITableView!
    @IBOutlet weak var refreshAppointments: UIBarButtonItem!
    
    var hospitalAppointments = [HospitalAppointments]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appointsTableView.delegate = self
        self.appointsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        HttpHandler.get(url: Constants.BASE_URL + "hospitals/appointments/", queryParams: nil, responseHandler: {
            (json: JSON, success: Bool) in
            if success {
                var appointments = [HospitalAppointments]()
                for (_, subJson):(String, JSON) in json {
                    let appointment = HospitalAppointments(
                        id: subJson["id"].intValue,
                        donor_id: subJson["donor"]["id"].intValue,
                        donor_name: subJson["donor"]["name"].stringValue,
                        date: subJson["date"].stringValue,
                        blood_group_id: subJson["donor"]["blood_group_id"].intValue)
                    appointments.append(appointment)
                }
                self.hospitalAppointments = appointments
                self.appointsTableView.reloadData()
            }
        })
    }
    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hospitalAppointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "hospitalAppointment") as? HospitalAppointMentViewCell else {
            fatalError("unable to type cast")
        }
        let appointment = self.hospitalAppointments[indexPath.row]
        cell.appointmentDate.text = appointment.date
        cell.userName.text = appointment.donor_name
        GeneralUtils.makeItCircle(viewObject: cell.bloodGroupThumb)
     
        return cell
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        print(indexPath.row)
        let doneAction = UITableViewRowAction(style: .default, title: "Done", handler: { (action, indexPath) in
            self.markAppointmentAsDone(indexPath: indexPath)
        })
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            self.cancelAppointment(indexPath: indexPath)
        })
        doneAction.backgroundColor = .green
        deleteAction.backgroundColor = .red
        return [doneAction, deleteAction]
    }

    func getAppointmentId(indexPath: IndexPath) -> Int{
        let appointment = self.hospitalAppointments[indexPath.row]
        return appointment.id!
    }
    func markAppointmentAsDone(indexPath: IndexPath) {
        let parameters: Parameters = [
            "op": 2
        ]
        self.updateAppointment(parameters: parameters, appointment_id: self.getAppointmentId(indexPath: indexPath), indexPath: indexPath)
    }
    
    func cancelAppointment(indexPath: IndexPath) {
        let parameters: Parameters = [
            "op": 1
        ]
        self.updateAppointment(parameters: parameters, appointment_id: self.getAppointmentId(indexPath: indexPath), indexPath: indexPath)
    }
    
    func updateAppointment(parameters: Parameters, appointment_id: Int, indexPath: IndexPath) {
        HttpHandler.get(url: Constants.BASE_URL + "appointments/\(String(appointment_id))/update/", queryParams: parameters, responseHandler: {(_, sucess: Bool) in
            self.hospitalAppointments.remove(at: indexPath.row)
            self.appointsTableView.deleteRows(at: [indexPath], with: .fade)
        })
    }
    
}
