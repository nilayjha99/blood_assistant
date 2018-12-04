//
//  BlackButton.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-03.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit.UIButton

class BlackButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        GeneralUtils.setBorder(viewObject: self, borderColor: UIColor.black.cgColor, borderWidth: 2)
        setTitleColor(UIColor.white, for: .normal)
        self.backgroundColor = UIColor.black
        GeneralUtils.makeRoundCorners(viewObject: self, radius: 2)
    }
}
