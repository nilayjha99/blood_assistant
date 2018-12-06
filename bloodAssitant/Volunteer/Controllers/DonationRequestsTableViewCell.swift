//
//  DonationRequestsTableViewCell.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-06.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit

class DonationRequestsTableViewCell: UITableViewCell {

    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bloodGroupLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
