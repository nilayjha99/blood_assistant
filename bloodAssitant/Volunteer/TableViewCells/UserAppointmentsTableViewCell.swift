//
//  UserAppointmentsTableViewCell.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-03.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit

class UserAppointmentsTableViewCell: UITableViewCell {

    @IBOutlet weak var appointmentDate: UILabel!
    @IBOutlet weak var hospitalName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
