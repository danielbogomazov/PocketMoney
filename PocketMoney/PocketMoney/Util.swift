//
//  Util.swift
//  PocketMoney
//
//  Created by Daniel on 2017-10-14.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit
import Foundation

open class Util {
    
    struct Constant {
        static let TINT_COLOR = UIColor(red: 84/255, green: 84/255, blue: 84/255, alpha: 1.0)
    }
    
    // MARK:- Date functions
    public class func stringToDate(_ date: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter.date(from: date)!
    }
    
    public class func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter.string(from: date)
    }
}

