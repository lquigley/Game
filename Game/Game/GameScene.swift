//
//  GameScene.swift
//  Game
//
//  Created by Luke Quigley on 9/18/14.
//  Copyright (c) 2014 Quigley. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var _speed:NSInteger = 1
    var _lastSecond:CFTimeInterval = 0.0
    var _sameTouch:Bool = false
    
    var backgroundView:GVBackground?
    var balloon:GVBalloon = GVBalloon()
    var ground:GVGround = GVGround()
    
    override func didMoveToView(view: SKView) {
        let midPoint = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds))
        
        //Add a gradient to the background
        self.backgroundView = GVBackground(size: view.frame.size)
        self.backgroundView!.position = midPoint
        self.addChild(self.backgroundView!)
        
        //Set up ground
        self.ground.position = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetHeight(self.ground.frame) / 2)
        self.addChild(self.ground)
        
        //Set up balloon
        self.balloon.position = midPoint
        self.addChild(self.balloon)
        
        self.physicsWorld.gravity = CGVectorMake(0, -1)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.balloon.physicsBody!.resting = true
        self.assessTouches(touches)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        self.assessTouches(touches)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        self.assessTouches(touches)
        
        let action = SKAction.rotateToAngle(0, duration: 2.0)
        self.balloon.runAction(action)
    }
    
    func assessTouches(touches:NSSet) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            let action = SKAction.moveTo(location, duration: 0.0)
            self.balloon.runAction(action)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        let diceRoll = Int(arc4random_uniform(UInt32(CGRectGetWidth(self.view!.frame))))
        
        if (_speed == 1) {
            // One cloud/second
            if currentTime - _lastSecond > 2 {
                let cloud = GVCloud()
                cloud.position = CGPointMake(CGFloat(diceRoll), CGRectGetHeight(self.view!.frame))
                self.addChild(cloud)
                _lastSecond = currentTime
            }
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let node = contact.bodyA.node;
        if node!.isKindOfClass(GVCloud) {
            self.balloon.xScale *= 1.3
            self.balloon.yScale *= 1.3
        }
    }
}
