//
//  GeneralUtils.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-11-13.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//
import UIKit.UIView

class GeneralUtils {
    public static func makeRoundCorners(viewObject: UIView, radius: Int) {
        viewObject.layer.cornerRadius = CGFloat(radius)
        viewObject.layer.masksToBounds = true
    }
    
    public static func makeItCircle(viewObject: UIView) {
        viewObject.layer.cornerRadius = (viewObject.frame.size.width / 2)
        viewObject.layer.masksToBounds = true
    }
    
    public static func setBorder(viewObject: UIView, borderColor: CGColor, borderWidth: Int) {
        viewObject.layer.borderColor = borderColor
        viewObject.layer.borderWidth = CGFloat(borderWidth)
    }
}
