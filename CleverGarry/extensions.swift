//
//  extensions.swift
//  CleverGarry
//
//  Created by Tony Parker on 1/3/16.
//  Copyright © 2016 Tony Parker. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

extension CAGradientLayer {
    class func gradientLayerForBounds(bounds: CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = bounds
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.colors = [UIColor(netHex: 0x475EDE).CGColor,
                        UIColor(netHex: 0x303F9F).CGColor,
                        UIColor(netHex: 0x475EDE).CGColor]
        return layer
    }
}

extension UIColor {    
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

