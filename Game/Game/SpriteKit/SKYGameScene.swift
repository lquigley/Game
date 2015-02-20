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
    func balloonSizeChanged(size: Int)
}

class SKYGameScene: SKScene, SKPhysicsContactDelegate, SKYBalloonDelegate {
    
    var _lastBirdSecond:CFTimeInterval = 0.0
    var _lastCloudSecond:CFTimeInterval = 0.0
    var _sameTouch:Bool = false
    var _score:Int = 0
    var _level:Int = 0
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
        
        let leftWall = SKYWall(size: CGSizeMake(10, CGRectGetHeight(self.view!.frame)))
        leftWall.position = CGPointMake(-10, 0);
        addChild(leftWall)
        
        let rightWall = SKYWall(size: CGSizeMake(10, CGRectGetHeight(self.view!.frame)))
        rightWall.position = CGPointMake(CGRectGetWidth(self.view!.frame) / 2 + 10, 0);
        addChild(rightWall)
        
        let bottom = SKYWall(size: CGSizeMake(CGRectGetWidth(self.view!.frame), 10))
        bottom.position = CGPointMake(0, -10);
        addChild(bottom)
        
        self.reset()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if (!balloon.exploded) {
            self.balloon.physicsBody!.resting = true
            
            if !_started {
                self.start()
                _started = true
            }
            self.assessTouches(touches)
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        if (!balloon.exploded) {
            self.assessTouches(touches)
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if (!balloon.exploded) {
            self.assessTouches(touches)
            
            let action = SKAction.rotateToAngle(0, duration: 2.0)
            self.balloon.runAction(action)
        }
    }
    
    func assessTouches(touches:NSSet) {
        for touch: AnyObject in touches {
            var location = touch.locationInNode(self)
            
            //Offset the finger to 100 points below the balloon.
            location.y = CGRectGetHeight(self.frame) * 0.33
            
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
            
            //One cloud/two second
            if currentTime - _lastCloudSecond > 0.5 {
                addCloud()
                _lastCloudSecond = currentTime
            }
            //One cloud/two second
            if currentTime - _lastBirdSecond > 1.5 {
                addBaddie()
                _lastBirdSecond = currentTime
            }
            
            self.score += 1
            
            self.scoreDelegate?.updatedScore(_score)
        }
    }
    
    func addCloud() {
        let diceRoll = Int(arc4random_uniform(UInt32(CGRectGetWidth(view!.frame))))
        let cloud = SKYCloud()
        cloud.position = CGPointMake(CGFloat(diceRoll), CGRectGetHeight(view!.frame))
        addChild(cloud)
    }
    
    func addBaddie() {
        var baddie:SKYBaddie
        switch _level {
        case 1:
            baddie = SKYBird2()
            break
        case 2:
            baddie = SKYPlane()
            break
        case 3:
            baddie = SKYEel()
            break
        case 4:
            baddie = SKYPlanet()
            break
        default:
            baddie = SKYBird()
            break
        }
        
        if (baddie.physicsBody?.velocity.dx == 0) {
            // No velocity so put it somewhere in the middle and let it fall.
            let xValueRoll = CGFloat(arc4random_uniform(UInt32(CGRectGetWidth(view!.frame))))
            baddie.position = CGPointMake(xValueRoll, CGRectGetHeight(view!.frame))
        } else {
            let yValueRoll = CGRectGetHeight(view!.frame) - CGFloat(arc4random_uniform(200))
            if (baddie.direction == SKYBaddieDirection.Left) {
                baddie.position = CGPointMake(0, yValueRoll)
            } else {
                baddie.position = CGPointMake(CGRectGetWidth(view!.frame), yValueRoll)
            }
        }
        addChild(baddie)
    }
    
    func reset() {
        balloon.reset()
        
        _started = false
        physicsWorld.gravity = CGVectorMake(0, 0)
        
        enumerateChildNodesWithName("GoodNode", usingBlock: {
            (node:SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            node.removeFromParent()
        })
        enumerateChildNodesWithName("BadNode", usingBlock: {
            (node:SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            node.removeFromParent()
        })
        
        let midPoint = CGPointMake(CGRectGetMidX(view!.bounds) / 2, CGRectGetMidY(view!.bounds) / 2)
        
        //Set up ground
        let action:SKAction = SKAction.moveTo(CGPointMake(190, 60), duration: 0)
        ground.runAction(action)
        ground.physicsBody?.resting = true
        if ground.parent == nil {
            addChild(ground)
        }
        
        //Set up balloon
        balloon.delegate = self
        balloon.position = midPoint
        balloon.reset()
        if balloon.parent == nil {
            addChild(balloon)
        }
        
        let highestScore = NSUserDefaults.standardUserDefaults().integerForKey(SKYUserDefaultKeys.highScore)
        if _score > highestScore {
            NSUserDefaults.standardUserDefaults().setInteger(_score, forKey: SKYUserDefaultKeys.highScore)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        scoreDelegate?.updatedScore(_score)
        
        _score = 0
    }
    
    func start() {
        physicsWorld.gravity = CGVectorMake(0, -5)
        scoreDelegate?.startedGame()
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        if nodeA!.isKindOfClass(SKYBalloon) {
            if nodeB != nil && nodeB!.isKindOfClass(SKYCloud) {
                balloon.increaseSize()
            } else if nodeB != nil && nodeB!.isKindOfClass(SKYBaddie) {
                balloon.decreaseSize()
            }
            nodeB?.removeFromParent()
        }
    }
    
    func balloonExploded(balloon: SKYBalloon) {
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "endGame", userInfo: nil, repeats: false)
    }
    
    func endGame() {
        self.reset()
        self.scoreDelegate?.endedGame()
    }
    
    var score:Int {
        get {
            return _score
        }
        set {
            if (_score != newValue) {
                _score = newValue
                
                let expectedLevel = Int(floorf(Float(_score) / Float(SKYLevelConstants.levelPoints)))
                if (expectedLevel > _level) {
                    self.level = expectedLevel
                }
            }
        }
    }
    
    var level:Int {
        get {
            return _level
        }
        set {
            if (_level != newValue) {
                _level = newValue
                
                //Drop a level icon
                let levelRope = SKYLevelRope()
                levelRope.level = _level
                levelRope.position = CGPointMake (CGRectGetWidth(self.view!.frame) / 2, CGRectGetHeight(self.view!.frame))
                addChild(levelRope)
            }
        }
    }
}
