//
//  GVBalloon.swift
//  Game2
//
//  Created by Luke Q on 9/18/14.
//  Copyright (c) 2014 Quigley. All rights reserved.
//

import SpriteKit

class GVBalloon: SKSpriteNode {
    
    convenience override init () {
        let texture:SKTexture = SKTexture(imageNamed: "Spaceship")
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
    }
    
    override init(texture: SKTexture?, color: SKColor?, size: CGSize) {
        super.init(texture: texture, color:color, size:size)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
