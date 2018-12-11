//
//  BorderedTextField.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-03.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit.UITextField

class BorderedTextField: UITextField {
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        GeneralUtils.setBorder(viewObject: self, borderColor: UIColor.black.cgColor, borderWidth: 2)
        self.textColor = UIColor.black
        GeneralUtils.makeRoundCorners(viewObject: self, radius: 2)
    }
}
