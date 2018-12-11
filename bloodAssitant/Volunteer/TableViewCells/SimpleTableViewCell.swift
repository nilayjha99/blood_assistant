//
//  SimpleTableViewCell.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-05.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit

class SimpleTableViewCell: UITableViewCell {
    @IBOutlet weak var itemLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
