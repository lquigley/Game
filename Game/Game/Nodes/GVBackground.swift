//
//  GVBackground.swift
//  Game
//
//  Created by Luke Quigley on 9/18/14.
//  Copyright (c) 2014 Quigley. All rights reserved.
//

import UIKit

import SpriteKit
import QuartzCore

class GVBackground: SKSpriteNode {
    
    convenience init (size:CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, true, 1)
        let context = UIGraphicsGetCurrentContext()
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRectMake(0, 0, size.width, size.height)
        let topColor:CGColor = SKColor(red: 46/255, green: 195/255, blue: 229/255, alpha: 1.0).CGColor
        let bottomColor:CGColor = SKColor(red: 133/255, green: 211/255, blue: 229/155, alpha: 1.0).CGColor
        gradient.colors = [topColor, bottomColor]
        gradient.renderInContext(context)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let texture = SKTexture(image: image)
        self.init(texture: texture, color: SKColor.whiteColor(), size:size)
    }
    
    override init(texture: SKTexture?, color: SKColor?, size: CGSize) {
        super.init(texture: texture, color:color, size:size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
}
