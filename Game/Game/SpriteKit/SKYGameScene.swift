//
//  SKYGameScene.swift
//  Sky High
//
//  Created by Luke Quigley on 9/18/14.
//  Copyright (c) 2014 Quigley. All rights reserved.
//

import SpriteKit

protocol SKYGameSceneScoreDelegate {
    func updatedScore(score: Int)
    func startedGame()
    func endedGame()
}

class SKYGameScene: SKScene, SKPhysicsContactDelegate, SKYBalloonDelegate {
    
    var _speed:Int = 1
    var _lastBirdSecond:CFTimeInterval = 0.0
    var _lastCloudSecond:CFTimeInterval = 0.0
    var _sameTouch:Bool = false
    var _score:Int = 0
    var _started:Bool = false
    
    var scoreDelegate:SKYGameSceneScoreDelegate?
    
    var balloon:SKYBalloon = SKYBalloon()
    var ground:SKYGround = SKYGround()
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func didMoveToView(view: SKView) {
        let midPoint = CGPointMake(CGRectGetMidX(self.view!.bounds), CGRectGetMidY(self.view!.bounds))
        
        self.physicsWorld.contactDelegate = self;
        
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
            
            //Offset the finger to 100 points below the balloon.
            location.y += 100
            
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
        if (_started) {
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
                
                _score += 1
            }
            
            self.scoreDelegate?.updatedScore(_score)
        }
    }
    
    func addCloud() {
        let diceRoll = Int(arc4random_uniform(UInt32(CGRectGetWidth(self.view!.frame))))
        let cloud = SKYCloud()
        cloud.position = CGPointMake(CGFloat(diceRoll), CGRectGetHeight(self.view!.frame))
        self.addChild(cloud)
    }
    
    func addBird() {
        let bird = SKYBird()
        bird.position = CGPointMake(0, CGRectGetHeight(self.view!.frame))
        self.addChild(bird)
    }
    
    func reset() {
        _started = false
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
        self.enumerateChildNodesWithName("GoodNode", usingBlock: {
            (node:SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            node.removeFromParent()
        })
        self.enumerateChildNodesWithName("BadNode", usingBlock: {
            (node:SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            node.removeFromParent()
        })
        
        let midPoint = CGPointMake(CGRectGetMidX(self.view!.bounds) / 2, CGRectGetMidY(self.view!.bounds) / 2)
        
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
        
        let highestScore = NSUserDefaults.standardUserDefaults().integerForKey("HighScore")
        if _score > highestScore {
            NSUserDefaults.standardUserDefaults().setInteger(_score, forKey: "HighScore")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        self.scoreDelegate?.updatedScore(_score)
        self.scoreDelegate?.endedGame()
        
        _score = 0
    }
    
    func start() {
        self.physicsWorld.gravity = CGVectorMake(0, -1)
        self.scoreDelegate?.startedGame()
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        if nodeA!.isKindOfClass(SKYBalloon) {
            if nodeB != nil && nodeB!.isKindOfClass(SKYCloud) {
                self.balloon.decreaseSize()
            } else if nodeB!.isKindOfClass(SKYBird) {
                self.balloon.increaseSize()
            }
            nodeB?.removeFromParent()
        }
    }
    
    func balloonExploded(balloon: SKYBalloon) {
        balloon.reset()
        self.reset()
    }
}
