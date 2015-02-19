//
//  NSNumberFormatter.swift
//  Sky High
//
//  Created by Luke Quigley on 2/19/15.
//  Copyright (c) 2015 VOKAL. All rights reserved.
//

import Foundation

extension NSNumberFormatter {
    class var thousandFormatter: NSNumberFormatter {
        struct ThousandFormatter {
            static var instance: NSNumberFormatter?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&ThousandFormatter.token) {
            ThousandFormatter.instance = NSNumberFormatter()
            ThousandFormatter.instance?.numberStyle = NSNumberFormatterStyle.DecimalStyle
        }
        
        return ThousandFormatter.instance!
    }
}
