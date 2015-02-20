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
    
    var bottomColor:UIColor!
    var topColor:UIColor!
    
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
        topColor = UIColor.levelOneTopColor
        bottomColor = UIColor.levelOneBottomColor
        gradient.colors = [topColor.CGColor, bottomColor.CGColor]
        gradient.renderInContext(context)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.image = image
    }
    
    func updateBackgroundForScore(score: Int) {
        //TODO: Change color here based on score.
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
