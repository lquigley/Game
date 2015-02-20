//
//  SKYConstants.swift
//  Sky High
//
//  Created by Luke Quigley on 9/18/14.
//  Copyright (c) 2014 Quigley. All rights reserved.
//

struct SKYCollisionGroups {
    var balloonCategory:UInt32     = 0x1;
    var goodSpriteCategory:UInt32  = 0x2;
    var badSpriteCategory:UInt32   = 0x3;
    var wallSpriteCategory:UInt32  = 0x4;
}

class SKYUserDefaultKeys {
    class var highScore:String {
        get {
            return "HighScore"
        }
    }
}

class SKYSegueIdentifiers {
    class var startToGoSegue:String {
        get {
            return "StartToGoSegue"
        }
    }
}

class SKYLevelConstants {
    class var levelPoints:Int {
        get {
            return 500
        }
    }
}