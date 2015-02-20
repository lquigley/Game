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
    
    var bottomColor:UIColor = UIColor.levelOneTopColor
    var topColor:UIColor = UIColor.levelOneBottomColor
    var percentage:CGFloat = 1.0
    
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
        gradient.colors = [topColor.blackenByPercentage(percentage).CGColor, bottomColor.blackenByPercentage(percentage).CGColor]
        gradient.renderInContext(context)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.image = image
    }
    
    func updateBackgroundForScore(score: Int) {
        percentage = 1 - (CGFloat(score) / CGFloat(SKYLevelConstants.levelPoints * 6))
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
