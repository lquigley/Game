//
//  GameScene.swift
//  Game
//
//  Created by Luke Quigley on 9/18/14.
//  Copyright (c) 2014 Quigley. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var _speed:Int = 1;
    var _sameTouch:Bool = false
    
    var backgroundView:GVBackground?
    var balloon:GVBalloon = GVBalloon()
    
    override func didMoveToView(view: SKView) {
        let midPoint = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds))
        
        //Add a gradient to the background
        self.backgroundView = GVBackground(size: view.frame.size)
        self.backgroundView!.position = midPoint
        self.addChild(self.backgroundView!)
        
        //Set up balloon
        self.addChild(self.balloon)
        self.balloon.position = midPoint
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.assessTouches(touches)
        _sameTouch = false
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        self.assessTouches(touches)
        _sameTouch = true
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        self.assessTouches(touches)
        _sameTouch = false
        
    }
    
    func assessTouches(touches:NSSet) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            let action = SKAction.moveTo(location, duration: 0.0)
            if !_sameTouch {
                action.duration = 2.0
            }
            self.balloon.runAction(action)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        if (self.balloon.physicsBody!.velocity.dy > 400) {
            self.balloon.physicsBody!.velocity = CGVectorMake(self.balloon.physicsBody!.velocity.dx, 400);
        }
        
        // rotate balloon on move
        let rotation = (Double)((self.balloon.physicsBody!.velocity.dy + 400) / (2.0*400)) * M_2_PI;
        self.balloon.zRotation = (CGFloat)(rotation-M_1_PI/2.0)
        
        let cloud = GVCloud()
        self.addChild(cloud)
    }
}
