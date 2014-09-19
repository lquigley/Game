//
//  GVBalloon.swift
//  Game2
//
//  Created by Luke Quigley on 9/18/14.
//  Copyright (c) 2014 Quigley. All rights reserved.
//

import SpriteKit

protocol GVBalloonDelegate {
    func balloonExploded(balloon:GVBalloon)
}

class GVBalloon: SKSpriteNode {
    
    var delegate:GVBalloonDelegate?
    var sizeLevel:Int = 1
    
    convenience override init () {
        let texture:SKTexture = SKTexture(imageNamed: "balloon")
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGRectGetWidth(self.frame) / 2)
        self.physicsBody!.allowsRotation = true
        self.physicsBody!.density = 300
        self.physicsBody!.affectedByGravity = false;
        self.physicsBody!.categoryBitMask = 0x1
        self.physicsBody!.collisionBitMask = 0x1
        self.physicsBody!.contactTestBitMask = 0x1
    }
    
    func reset() {
        sizeLevel = 1
        self.physicsBody?.resting = true
        self.xScale = CGFloat(sizeLevel)
        self.yScale = CGFloat(sizeLevel)
    }
    
    override init(texture: SKTexture?, color: SKColor?, size: CGSize) {
        super.init(texture: texture, color:color, size:size)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func increaseSize() {
        sizeLevel++
        
        if (sizeLevel > 4) {
            self.delegate?.balloonExploded(self)
        } else {
            let action:SKAction = SKAction.scaleBy(1.3, duration: 1)
            self.runAction(action)
        }
    }
    
    func decreaseSize() {
        sizeLevel--
        
        if sizeLevel < 1 {
            self.delegate?.balloonExploded(self)
        } else {
            let action:SKAction = SKAction.scaleBy(-1.3, duration: 1)
            self.runAction(action)
        }
    }
}
