//
//  HospitalAppointmentsViewController.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-11-15.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit

class HospitalAppointmentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var appointsTableView: UITableView!
    @IBOutlet weak var refreshAppointments: UIBarButtonItem!
    
    let dummyArray = ["A","B", "C", "D", "E"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appointsTableView.delegate = self
        self.appointsTableView.dataSource = self
    }
    
    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dummyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "hospitalAppointment") as? HospitalAppointMentViewCell else {
            fatalError("unable to type cast")
        }
        
        cell.appointmentDate.text = "11/12/2018 at 8:55 PM"
        cell.userName.text = "Johnthah Doe one"
        GeneralUtils.calculateRadusforCircle(viewObject: cell.bloodGroupThumb)
     
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
            self.showAlert(indexPath: indexPath)
        })
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            self.showAlert(indexPath: indexPath)
        })
        doneAction.backgroundColor = .green
        deleteAction.backgroundColor = .red
        return [doneAction, deleteAction]
    }


    func showAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Donation Completed",
                                      message: "user has completed donation of \(indexPath.row)",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil);
        alert.addAction(action)
        present(alert, animated: true)
    }
}
