//
//  NSNumberFormatter.swift
//  Sky High
//
//  Created by Luke Quigley on 2/19/15.
//  Copyright (c) 2015 VOKAL. All rights reserved.
//

import Foundation

class SKYNumberFormatter: NSNumberFormatter {
    class var thousandFormatter: SKYNumberFormatter {
        struct ThousandFormatter {
            static var instance: SKYNumberFormatter?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&ThousandFormatter.token) {
            ThousandFormatter.instance = SKYNumberFormatter()
            ThousandFormatter.instance?.numberStyle = NSNumberFormatterStyle.DecimalStyle
        }
        
        return ThousandFormatter.instance!
    }
}
