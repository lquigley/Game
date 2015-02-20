//
//  SKYBalloon.swift
//  Sky High
//
//  Created by Luke Quigley on 9/18/14.
//  Copyright (c) 2014 Quigley. All rights reserved.
//

import SpriteKit

protocol SKYBalloonDelegate {
    func balloonExploded(balloon:SKYBalloon)
}

class SKYBalloon: SKSpriteNode {
    
    var delegate:SKYBalloonDelegate?
    var sizeLevel:Int = 2
    var exploded:Bool = false
    
    convenience override init () {
        let texture:SKTexture = SKTexture(imageNamed: "Balloon")
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGRectGetWidth(self.frame) / 2)
        self.physicsBody!.allowsRotation = true
        self.physicsBody!.density = 300
        self.physicsBody!.affectedByGravity = false;
        self.physicsBody!.categoryBitMask = 0x1
        self.physicsBody!.collisionBitMask = 0x2 | 0x3 | 0x4
        self.physicsBody!.contactTestBitMask = 0x2 | 0x3
    }
    
    func reset() {
        exploded = false
        sizeLevel = 2
        
        let changeImage = SKAction.setTexture(SKTexture(imageNamed: "Balloon"))
        self.runAction(changeImage)
        
        self.physicsBody?.resting = true
        self.xScale = CGFloat(1)
        self.yScale = CGFloat(1)
    }
    
    override init(texture: SKTexture?, color: SKColor?, size: CGSize) {
        super.init(texture: texture, color:color, size:size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func increaseSize() {
        sizeLevel++
        
        if (sizeLevel > 5) {
            explode()
        } else {
            let action:SKAction = SKAction.scaleBy(1.4, duration: 0.3)
            self.runAction(action)
        }
    }
    
    func decreaseSize() {
        sizeLevel--
        
        if sizeLevel < 1 {
            explode()
        } else {
            let action:SKAction = SKAction.scaleBy(0.714, duration: 0.3)
            self.runAction(action)
        }
    }
    
    func explode() {
        exploded = true
        
        let changeImage = SKAction.setTexture(SKTexture(imageNamed: "Pop"))
        self.runAction(changeImage)
        self.delegate?.balloonExploded(self)
    }
}
