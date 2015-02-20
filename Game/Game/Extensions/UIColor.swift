//
//  UIColor.swift
//  Sky High
//
//  Created by Luke Quigley on 2/19/15.
//  Copyright (c) 2015 VOKAL. All rights reserved.
//

import UIKit

extension UIColor {
    class var levelOneTopColor: UIColor {
        return UIColor(red: 46/255, green: 195/255, blue: 229/255, alpha: 1.0)
    }
    
    class var levelOneBottomColor: UIColor {
        return UIColor(red: 133/255, green: 211/255, blue: 229/155, alpha: 1.0)
    }
    
    func blackenByPercentage(percentage: CGFloat) -> UIColor {
        //Takes a color and makes it blacker by the percentage
        var red:CGFloat = 0.0
        var green:CGFloat = 0.0
        var blue:CGFloat = 0.0
        var alpha:CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: red * percentage, green: green * percentage, blue: blue * percentage, alpha: alpha)
    }
}
