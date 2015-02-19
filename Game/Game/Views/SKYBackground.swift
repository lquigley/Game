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
        let topColor:CGColor = UIColor.levelOneTopColor.CGColor
        let bottomColor:CGColor = UIColor.levelOneBottomColor.CGColor
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
