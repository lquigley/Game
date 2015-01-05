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
    var _lastBirdSecond:CFTimeInterval = 0.0
    var _lastCloudSecond:CFTimeInterval = 0.0
    var _sameTouch:Bool = false
    var _score:Int = 0
    var _started:Bool = false
    
    var backgroundView:GVBackground?
    var balloon:GVBalloon = GVBalloon()
    var ground:GVGround = GVGround()
    var goodLuckNode:SKLabelNode = SKLabelNode()
    var scoreLabel:SKLabelNode = SKLabelNode()
    var highScoreLabel:SKLabelNode = SKLabelNode()
    
    override func didMoveToView(view: SKView) {
        let midPoint = CGPointMake(CGRectGetMidX(self.view!.bounds), CGRectGetMidY(self.view!.bounds))
        
        self.physicsWorld.contactDelegate = self;
        
        //Add a gradient to the background
        self.backgroundView = GVBackground(size: self.view!.frame.size)
        self.backgroundView!.position = midPoint
        self.addChild(self.backgroundView!)
        
        self.highScoreLabel.position = CGPointMake(CGRectGetMidX(self.view!.bounds), 500)
        let highestScore = NSUserDefaults.standardUserDefaults().integerForKey("HighScore")
        self.highScoreLabel.text = "\(highestScore)"
        //self.addChild(highScoreLabel)
        
        self.scoreLabel.position = CGPointMake(CGRectGetMidX(self.view!.bounds), 480)
        self.addChild(self.scoreLabel)
        
        self.reset()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.balloon.physicsBody!.resting = true
        
        if !_started {
            self.start()
            _started = true
        }
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
        self.enumerateChildNodesWithName("BadNode", usingBlock: {
            (node:SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            if CGRectGetMaxY(node.frame) < 0 {
                node.removeFromParent()
            }
        })
        
        if _speed == 1 {
            // One cloud/two second
            if currentTime - _lastCloudSecond > 0.5 {
                self.addCloud()
                _lastCloudSecond = currentTime
            }
            // One cloud/two second
            if currentTime - _lastBirdSecond > 1 {
                self.addBird()
                _lastBirdSecond = currentTime
            }
            
            if _started {
                _score += 1
            }
        }
        
        self.scoreLabel.text = "\(_score)"
    }
    
    func addCloud() {
        let diceRoll = Int(arc4random_uniform(UInt32(CGRectGetWidth(self.view!.frame))))
        let cloud = GVCloud()
        cloud.position = CGPointMake(CGFloat(diceRoll), CGRectGetHeight(self.view!.frame))
        self.addChild(cloud)
    }
    
    func addBird() {
        let bird = GVBird()
        bird.position = CGPointMake(0, CGRectGetHeight(self.view!.frame))
        self.addChild(bird)
    }
    
    func reset() {
        self.enumerateChildNodesWithName("GoodNode", usingBlock: {
            (node:SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            node.removeFromParent()
        })
        self.enumerateChildNodesWithName("BadNode", usingBlock: {
            (node:SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            node.removeFromParent()
        })
        
        let midPoint = CGPointMake(CGRectGetMidX(self.view!.bounds), CGRectGetMidY(self.view!.bounds))
        
        //Set up ground
        let action:SKAction = SKAction.moveTo(CGPointMake(160, 60), duration: 0)
        self.ground.runAction(action)
        self.ground.physicsBody?.resting = true
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
        
        goodLuckNode.text = "Good Luck!"
        goodLuckNode.position = midPoint
        if goodLuckNode.parent == nil {
            self.addChild(goodLuckNode)
        }
        
        let highestScore = NSUserDefaults.standardUserDefaults().integerForKey("HighScore")
        if highestScore > _score {
            NSUserDefaults.standardUserDefaults().setInteger(_score, forKey: "HighScore")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        _score = 0
    }
    
    func start() {
        goodLuckNode.removeFromParent()
        self.physicsWorld.gravity = CGVectorMake(0, -1)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        if nodeA!.isKindOfClass(GVBalloon) {
            if nodeB!.isKindOfClass(GVCloud) {
                self.balloon.decreaseSize()
            } else if nodeB!.isKindOfClass(GVBird) {
                self.balloon.increaseSize()
            }
            nodeB?.removeFromParent()
        }
    }
    
    func balloonExploded(balloon: GVBalloon) {
        balloon.reset()
        self.reset()
    }
}
