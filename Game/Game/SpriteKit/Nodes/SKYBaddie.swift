//
//  SKYBaddie.swift
//  Sky High
//
//  Created by Luke Quigley on 2/20/15.
//  Copyright (c) 2015 VOKAL. All rights reserved.
//

import SpriteKit

enum SKYBaddieDirection : Int {
    
    case Left
    case Right
    
}

class SKYBaddie: SKSpriteNode {
    
    var direction:SKYBaddieDirection!
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        self.name = "BadNode"
        
        let intDirection = arc4random_uniform(2)
        switch intDirection {
        case 0:
            direction = SKYBaddieDirection.Left
            break
        default:
            direction = SKYBaddieDirection.Right
            break
        }
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGRectGetWidth(self.frame) / 2)
        self.physicsBody!.allowsRotation = true
        self.physicsBody!.density = 400
        self.physicsBody!.categoryBitMask = 0x3
        self.physicsBody!.collisionBitMask = 0x1
    }
    
    var velocity:CGFloat {
        get {
            return 0
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
