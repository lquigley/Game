//
//  GVBalloon.swift
//  Game2
//
//  Created by Luke Quigley on 9/18/14.
//  Copyright (c) 2014 Quigley. All rights reserved.
//

import SpriteKit

class GVBalloon: SKSpriteNode {
    
    convenience override init () {
        let texture:SKTexture = SKTexture(imageNamed: "balloon")
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGRectGetWidth(self.frame) / 2)
        self.physicsBody!.allowsRotation = true
        self.physicsBody!.density = 400
        self.physicsBody!.affectedByGravity = false;
        self.physicsBody!.collisionBitMask = kGoodSpriteCategory | kGoodSpriteCategory
        
        self.physicsBody!.categoryBitMask = kBalloonCategory
    }
    
    override init(texture: SKTexture?, color: SKColor?, size: CGSize) {
        super.init(texture: texture, color:color, size:size)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
