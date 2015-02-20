//
//  SKYEel.swift
//  Sky High
//
//  Created by Luke Quigley on 2/20/15.
//  Copyright (c) 2015 VOKAL. All rights reserved.
//

import SpriteKit

class SKYEel: SKYBaddie {
    
    convenience init () {
        let texture:SKTexture = SKTexture(imageNamed: "Night Eel")
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        if self.direction == SKYBaddieDirection.Left {
            self.xScale = -1
            self.physicsBody?.velocity = CGVectorMake(velocity, 20)
        } else {
            self.physicsBody?.velocity = CGVectorMake(-velocity, 20)
        }
    }
    
    override var velocity:CGFloat {
        get {
            return 200.0
        }
    }
}
