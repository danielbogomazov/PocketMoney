//
//  CGFloatExtension.swift
//  PocketMoney
//
//  Created by Daniel on 2017-11-20.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit

extension CGFloat {
    var degreesToRadians: CGFloat { return self * .pi / 180 }
    var radiansToDegrees: CGFloat { return self * 180 / .pi }
}
