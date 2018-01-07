//
//  Autofill.swift
//  PocketMoney
//
//  Created by Daniel on 2018-01-07.
//  Copyright © 2018 Daniel Bogomazov. All rights reserved.
//

import UIKit

class Autofill {
    private var string: NSMutableAttributedString!
    private var autofill: NSMutableAttributedString!
    private var fullString: NSMutableAttributedString!
    
    public init(string: String, autofill: String) {
        self.string = NSMutableAttributedString(string: string, attributes: [NSAttributedStringKey.foregroundColor: Util.Color.VIOLET])
        self.autofill = NSMutableAttributedString(string: autofill, attributes: [NSAttributedStringKey.foregroundColor: Util.Color.VIOLET.withAlphaComponent(0.3)])
        self.fullString = NSMutableAttributedString(string: string, attributes: [NSAttributedStringKey.foregroundColor: Util.Color.VIOLET])
        self.fullString.append(NSMutableAttributedString(string: autofill, attributes: [NSAttributedStringKey.foregroundColor: Util.Color.VIOLET.withAlphaComponent(0.3)]))
    }
        
    public func getString() -> NSMutableAttributedString {
        return string
    }
    
    public func setString(to string: String) {
        self.string = NSMutableAttributedString(string: string, attributes: [NSAttributedStringKey.foregroundColor: Util.Color.VIOLET])
    }
    
    public func getFullString() -> NSMutableAttributedString {
        return fullString
    }
}
