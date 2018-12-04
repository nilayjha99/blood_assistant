//
//  UserAppointmentsViewController.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-03.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit

class UserAppointmentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    


    @IBOutlet weak var appointmentsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appointmentsTableView.delegate = self
        self.appointmentsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
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
        cell.appointmentDate.text = "12/12/12 at 12:12 PM"
        cell.hospitalName.text = "Abcd hospital of regina"
        return cell
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
        }
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
