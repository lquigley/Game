//
//  SKYWall.swift
//  Sky High
//
//  Created by Luke Quigley on 2/20/15.
//  Copyright (c) 2015 VOKAL. All rights reserved.
//

import SpriteKit

class SKYWall: SKSpriteNode {
    
    convenience init(size: CGSize) {
        self.init()
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: size)
        self.physicsBody!.dynamic = false;
        self.physicsBody!.categoryBitMask = 0x4
        self.physicsBody!.collisionBitMask = 0x1
    }
    
    override init () {
        super.init()
    }
    
    required override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
