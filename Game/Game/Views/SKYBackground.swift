//
//  SKYBackground.swift
//  Sky High
//
//  Created by Luke Quigley on 9/18/14.
//  Copyright (c) 2014 Quigley. All rights reserved.
//

import UIKit

import QuartzCore

class SKYBackground: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func setup() {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, true, 1)
        
        let context = UIGraphicsGetCurrentContext()
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        let topColor:CGColor = UIColor(red: 46/255, green: 195/255, blue: 229/255, alpha: 1.0).CGColor
        let bottomColor:CGColor = UIColor(red: 133/255, green: 211/255, blue: 229/155, alpha: 1.0).CGColor
        gradient.colors = [topColor, bottomColor]
        gradient.renderInContext(context)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.image = image
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
