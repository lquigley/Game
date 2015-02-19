//
//  SKYStartViewController.swift
//  Sky High
//
//  Created by Luke Quigley on 2/19/15.
//  Copyright (c) 2015 VOKAL. All rights reserved.
//

import UIKit

class SKYStartViewController: UIViewController {
    
    @IBOutlet weak var highScoreLabel:UILabel!
    @IBOutlet weak var goButton:UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.highScoreLabel.text = "\(NSUserDefaults.standardUserDefaults().integerForKey(SKYUserDefaultKeys.highScore))"
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func goButtonSelected() {
        self.performSegueWithIdentifier(SKYSegueIdentifiers.startToGoSegue, sender: self)
    }
}
