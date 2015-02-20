//
//  SKYLevelRope.swift
//  Sky High
//
//  Created by Luke Quigley on 2/20/15.
//  Copyright (c) 2015 VOKAL. All rights reserved.
//

import SpriteKit

class SKYLevelRope: SKShapeNode {
    
    var _level:Int = 0
    
    override init() {
        super.init()
        
        let bezierPath = UIBezierPath()
        let startPoint = CGPointMake(0,250)
        let endPoint = CGPointMake(450,250)
        bezierPath.moveToPoint(startPoint)
        bezierPath.addLineToPoint(endPoint)
        
        var pattern : [CGFloat] = [10.0,5.0];
        let dashed = CGPathCreateCopyByDashingPath(bezierPath.CGPath, nil, 0, pattern, 2);
        
        let backNode = SKShapeNode(path: dashed, centered: true)
        self.addChild(backNode)
        
        self.physicsBody = SKPhysicsBody()
        self.physicsBody?.affectedByGravity = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var level:Int {
        get {
            return _level
        }
        set {
            let numberNode = SKSpriteNode()
        }
    }
}
