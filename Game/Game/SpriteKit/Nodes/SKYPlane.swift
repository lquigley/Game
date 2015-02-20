//
//  SKYPlane.swift
//  Sky High
//
//  Created by Luke Quigley on 2/20/15.
//  Copyright (c) 2015 VOKAL. All rights reserved.
//

import SpriteKit

class SKYPlane: SKYBaddie {
    
    convenience init () {
        //Random image of the two planes
        let diceRoll = Int(arc4random_uniform(2)) + 1
        let imageName = NSString.localizedStringWithFormat("Plane %d", diceRoll)
        
        let texture:SKTexture = SKTexture(imageNamed: imageName)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        let directionRoll = Int(arc4random_uniform(2))
        if directionRoll == 0 {
            self.physicsBody?.velocity = CGVectorMake(-400, 20)
        } else {
            self.xScale = -1
            self.physicsBody?.velocity = CGVectorMake(400, 20)
        }
    }
}
