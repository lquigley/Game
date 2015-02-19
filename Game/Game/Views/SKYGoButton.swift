//
//  SKYGoButton.swift
//  Sky High
//
//  Created by Luke Quigley on 2/19/15.
//  Copyright (c) 2015 VOKAL. All rights reserved.
//

import UIKit

class SKYGoButton: UIButton {
    
    var centerCircle:UIView!
    var borderWidth:CGFloat = 10.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clearColor()
        
        self.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        
        centerCircle = UIView()
        centerCircle.backgroundColor = UIColor.whiteColor()
        centerCircle.frame = CGRectMake(borderWidth, borderWidth, CGRectGetWidth(self.frame) - borderWidth * 2, CGRectGetHeight(self.frame) - borderWidth * 2)
        centerCircle.userInteractionEnabled = false
        centerCircle.layer.cornerRadius = CGRectGetHeight(self.centerCircle.frame) / 2
        centerCircle.layer.borderWidth = borderWidth
        centerCircle.layer.borderColor = UIColor.blackColor().colorWithAlphaComponent(0.1).CGColor
        self.addSubview(centerCircle)
    }
    
}