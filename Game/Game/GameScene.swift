//
//  GameScene.swift
//  Game
//
//  Created by Luke Quigley on 9/18/14.
//  Copyright (c) 2014 Quigley. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate, GVBalloonDelegate {
    
    var _speed:Int = 1
    var _lastSecond:CFTimeInterval = 0.0
    var _sameTouch:Bool = false
    var _score:Int = 0
    
    var backgroundView:GVBackground?
    var balloon:GVBalloon = GVBalloon()
    var ground:GVGround = GVGround()
    
    override func didMoveToView(view: SKView) {
        let midPoint = CGPointMake(CGRectGetMidX(self.view!.bounds), CGRectGetMidY(self.view!.bounds))
        
        self.physicsWorld.contactDelegate = self;
        
        //Add a gradient to the background
        self.backgroundView = GVBackground(size: self.view!.frame.size)
        self.backgroundView!.position = midPoint
        self.addChild(self.backgroundView!)
        
        self.reset()
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
            var location = touch.locationInNode(self)
            
            //Keep it in bounds
            let screenSize = self.view!.bounds;
            if location.x < 0 {
                location.x = 0
            } else if location.x > CGRectGetWidth(screenSize) {
                location.x = CGRectGetWidth(screenSize)
            }
            if location.y < 0 {
                location.y = 0
            } else if location.y > CGRectGetHeight(screenSize) {
                location.y = CGRectGetHeight(screenSize)
            }
            
            let action = SKAction.moveTo(location, duration: 0.0)

            self.balloon.runAction(action, completion: { () -> Void in
                self.balloon.physicsBody!.resting = true
            })
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        self.enumerateChildNodesWithName("GoodNode", usingBlock: {
            (node:SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            if CGRectGetMaxY(node.frame) < 0 {
                node.removeFromParent()
            }
        })
        
        if _speed == 1 {
            // One cloud/two second
            if currentTime - _lastSecond > 2 {
                self.addCloud()
                _lastSecond = currentTime
            }
            _score += 100
        } else if _speed == 2 {
            // One cloud/second
            if currentTime - _lastSecond > 1 {
                self.addCloud()
            }
            _score += 100
        }
    }
    
    func addCloud() {
        let diceRoll = Int(arc4random_uniform(UInt32(CGRectGetWidth(self.view!.frame))))
        let cloud = GVCloud()
        cloud.position = CGPointMake(CGFloat(diceRoll), CGRectGetHeight(self.view!.frame))
        self.addChild(cloud)
    }
    
    func reset() {
        let midPoint = CGPointMake(CGRectGetMidX(self.view!.bounds), CGRectGetMidY(self.view!.bounds))
        
        self.physicsWorld.gravity = CGVectorMake(0, -1)
        
        //Set up ground
        self.ground.position = CGPointMake(CGRectGetMidX(self.view!.bounds), self.ground.size.height / 2)
        self.ground.restoreUserActivityState(<#activity: NSUserActivity#>)
        NSLog("%@", self.ground)
        if self.ground.parent == nil {
            self.addChild(self.ground)
        }
        
        //Set up balloon
        self.balloon.delegate = self
        self.balloon.position = midPoint
        self.balloon.reset()
        if self.balloon.parent == nil {
            self.addChild(self.balloon)
        }
        
        _score = 0
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        if nodeA!.isKindOfClass(GVBalloon) {
            if nodeB!.isKindOfClass(GVCloud) {
                self.balloon.increaseSize()
            } else if nodeB!.isKindOfClass(GVBird) {
                self.balloon.decreaseSize()
            }
            nodeB?.removeFromParent()
        }
        
        if self.balloon.xScale > 4 {
            self.reset()
        }
    }
    
    func balloonExploded(balloon: GVBalloon) {
        self.reset()
    }
}
