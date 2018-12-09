//
//  UpdateRepoViewController.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-09.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit
import Alamofire

class UpdateRepoViewController: UIViewController {

    var bloodRepo = [BloodRepositoryModel]()
    
    @IBOutlet weak var unitsField: BorderedTextField!
    @IBOutlet weak var bloodGroupField: BorderedTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func getRepoId(blood_group_name: String) -> Int {
        let blood_group_id = Constants.BLOOD_GROUPS.firstIndex(of: self.bloodGroupField.text!)! + 1
        let blood_repo_id = self.bloodRepo.filter {$0.blood_group_id == blood_group_id}
        return blood_repo_id[0].blood_repo_id!
    }
    @IBAction func updateRepo(_ sender: Any) {
        let parameters: Parameters = [
            "units": Int(self.unitsField.text!)!
        ]
        HttpHandler.put(url: Constants.BASE_URL + "repository/\(self.getRepoId(blood_group_name: self.bloodGroupField.text!))/", data: parameters, responseHandler: {(_, success: Bool) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
