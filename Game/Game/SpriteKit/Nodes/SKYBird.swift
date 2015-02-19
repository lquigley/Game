//
//  SKYBird.swift
//  Sky High
//
//  Created by Luke Q on 9/19/14.
//  Copyright (c) 2014 Quigley. All rights reserved.
//

import SpriteKit

class SKYBird: SKSpriteNode {
    
    convenience override init () {
        //Random image of the two birds
        let diceRoll = Int(arc4random_uniform(2)) + 1
        let imageName = NSString.localizedStringWithFormat("Bird %d", diceRoll)
        
        let texture:SKTexture = SKTexture(imageNamed: imageName)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.name = "BadNode"
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGRectGetWidth(self.frame) / 2)
        self.physicsBody!.allowsRotation = true
        self.physicsBody!.density = 400
        self.physicsBody!.categoryBitMask = 0x1
        self.physicsBody!.collisionBitMask = 0x1
        self.physicsBody?.velocity = CGVectorMake(80, 0)
        
        let directionRoll = Int(arc4random_uniform(1))
        if directionRoll == 0 {
            self.xScale = -1
        }
    }
    
    override init(texture: SKTexture?, color: SKColor?, size: CGSize) {
        super.init(texture: texture, color:color, size:size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}