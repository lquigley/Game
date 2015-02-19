//
//  SKYViewController.swift
//  Sky High
//
//  Created by Luke Quigley on 9/18/14.
//  Copyright (c) 2014 Quigley. All rights reserved.
//

import UIKit
import SpriteKit

class SKYViewController: UIViewController, SKYGameSceneScoreDelegate {
    
    @IBOutlet weak var gameView:SKView!
    @IBOutlet weak var timeLabel:UILabel!
    @IBOutlet weak var scoreLabel:UILabel!
    @IBOutlet var noteLabel:UILabel!
    @IBOutlet weak var backgroundImageView:SKYBackground!
    
    var timer:NSTimer!
    var seconds:Int = 0
    
    required init(coder:NSCoder) {
        super.init(coder:coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SKYGameScene(size: self.view.bounds.size)
        scene.scoreDelegate = self
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        self.gameView.ignoresSiblingOrder = true
        self.gameView.sizeThatFits(self.view.frame.size)
        self.gameView.frame = CGRectMake(0, 0, self.view.bounds.size.width * 2, self.view.bounds.size.height * 2)
        self.gameView.allowsTransparency = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill;
        scene.backgroundColor = UIColor.clearColor()
        
        self.gameView.presentScene(scene)
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    func resetTimer() {
        seconds = -1
        timer?.invalidate()
        updateTime()
    }
    
    func updateTime() {
        seconds += 1
        
        let actualSeconds = seconds % 60
        let minutes = (actualSeconds / 60) % 60
        let strMinutes = minutes > 9 ? String(minutes) : "0" + String(minutes)
        let strSeconds = actualSeconds > 9 ? String(actualSeconds) : "0" + String(actualSeconds)
        
        self.timeLabel.text = "\(strMinutes):\(strSeconds)"
        
        if (seconds > 3) {
            UIView.transitionWithView(self.view, duration: 1.0, options: nil, animations: {
                self.noteLabel.alpha = 0.0
            }, completion: { finished in
                self.noteLabel.removeFromSuperview()
            })
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    //Game scene delegate
    
    func updatedScore(score: Int) {
        self.scoreLabel.text = NSNumberFormatter.thousandFormatter.stringFromNumber(score)
    }
    
    func startedGame() {
        //Remove good luck label.
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateTime", userInfo: nil, repeats: true)
    }
    
    func endedGame() {
        self.navigationController?.popViewControllerAnimated(false)
    }
}