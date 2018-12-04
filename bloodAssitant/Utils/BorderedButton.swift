//
//  BorderedButton.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-11-14.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit.UIButton

class RepositoryViewCell: UIButton {
    required init?(coder aDecoder: NSCoder) {
       
        super.init(coder: aDecoder)
        
        GeneralUtils.setBorder(viewObject: self, borderColor: UIColor.black.cgColor, borderWidth: 2)
        setTitleColor(UIColor.black, for: .normal)
        isUserInteractionEnabled = false 
    }
}
