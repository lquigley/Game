//
//  GameScene.swift
//  Game2
//
//  Created by Luke Q on 9/18/14.
//  Copyright (c) 2014 Quigley. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var _spaceshipSprite:GVBalloon!
    var spaceshipSprite:GVBalloon {
        get {
            if _spaceshipSprite == nil {
                _spaceshipSprite = GVBalloon()
                
                _spaceshipSprite.xScale = 0.25;
                _spaceshipSprite.yScale = 0.25;
                _spaceshipSprite.position = CGPointMake(0.5, 1.0);
                
                //_spaceshipSprite.physicsBody = SKPhysicsBody(circleOfRadius: _spaceshipSprite.size.width/2)
                
                self.addChild(_spaceshipSprite)
            }
            return _spaceshipSprite
        }
    }
    
    override func didMoveToView(view: SKView) {
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            let action = SKAction.moveTo(location, duration:2.0)
            spaceshipSprite.runAction(action)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
