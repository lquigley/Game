//
//  SKYBird.swift
//  Sky High
//
//  Created by Luke Quigley on 9/19/14.
//  Copyright (c) 2014 Quigley. All rights reserved.
//

import SpriteKit

class SKYBird: SKYBaddie {
    
    convenience init () {
        //Random image of the two birds
        let diceRoll = Int(arc4random_uniform(2)) + 1
        let imageName = NSString.localizedStringWithFormat("Bird %d", diceRoll)
        
        let texture:SKTexture = SKTexture(imageNamed: imageName)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        if direction == SKYBaddieDirection.Left {
            self.xScale = -1
            self.physicsBody?.velocity = CGVectorMake(velocity, 20)
        } else {
            self.physicsBody?.velocity = CGVectorMake(-1 * velocity, 20)
        }
    }
    
    override var velocity:CGFloat {
        get {
            return 200.0
        }
    }
}

class SKYBird2: SKYBaddie {
    
    convenience init () {
        //Random image of the two level2 birds
        var diceRoll = Int(arc4random_uniform(2)) + 1
        diceRoll += 2
        let imageName = NSString.localizedStringWithFormat("Bird %d", diceRoll)
        
        let texture:SKTexture = SKTexture(imageNamed: imageName)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        if direction == SKYBaddieDirection.Left {
            if (diceRoll == 3) {
                self.xScale = -1
            }
            self.physicsBody?.velocity = CGVectorMake(velocity, 20)
        } else {
            if (diceRoll == 4) {
                self.xScale = -1
            }
            self.physicsBody?.velocity = CGVectorMake(-1 * velocity, 20)
        }
    }
    
    override var velocity:CGFloat {
        get {
            return 200.0
        }
    }
}