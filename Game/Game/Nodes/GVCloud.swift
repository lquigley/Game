//
//  GVCloud.swift
//  Game
//
//  Created by Luke Quigley on 9/18/14.
//  Copyright (c) 2014 Quigley. All rights reserved.
//

import SpriteKit

class GVCloud: SKSpriteNode {
    
    convenience override init () {
        //Random image of the three clouds
        let diceRoll = Int(arc4random_uniform(3)) + 1
        let imageName = NSString.localizedStringWithFormat("Cloud %d", diceRoll)
        
        let texture:SKTexture = SKTexture(imageNamed: imageName)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.name = "GoodNode"
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGRectGetWidth(self.frame) / 2)
        self.physicsBody!.allowsRotation = true
        self.physicsBody!.density = 400
        self.physicsBody!.categoryBitMask = 0x1
        self.physicsBody!.collisionBitMask = 0x1
        
        //Random rotation to mix it up some more.
        let rotation = CGFloat(rand())/CGFloat(RAND_MAX)*2.0
        self.zRotation = rotation
    }
    
    override init(texture: SKTexture?, color: SKColor?, size: CGSize) {
        super.init(texture: texture, color:color, size:size)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
