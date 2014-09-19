//
//  GVGround.swift
//  Game
//
//  Created by Luke Quigley on 9/18/14.
//  Copyright (c) 2014 Quigley. All rights reserved.
//

import SpriteKit

class GVGround: SKSpriteNode {
    
    convenience override init () {
        let texture:SKTexture = SKTexture(imageNamed: "Ground")
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.physicsBody = SKPhysicsBody()
        self.physicsBody?.affectedByGravity = true
    }
    
    override init(texture: SKTexture?, color: SKColor?, size: CGSize) {
        super.init(texture: texture, color:color, size:size)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
}
