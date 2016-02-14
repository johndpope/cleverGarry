//
//  ScanOverlayView.swift
//  CleverGarry
//
//  Created by Tony Parker on 1/8/16.
//  Copyright © 2016 Tony Parker. All rights reserved.
//

import Foundation
import UIKit


class ScanOverlayView : UIView {
    

    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        CGContextClearRect(context, rect)
        
        let squareSize = CGSizeMake(rect.width * 0.80, rect.width * 0.80)
        let squareRect = CGRectMake(rect.width*0.1, rect.width*0.1, squareSize.width, squareSize.height)
        
        CGContextSetFillColorWithColor(context, UIColor(red: 0, green: 0, blue: 0.01, alpha: 0.5
            ).CGColor)
        CGContextFillRect(context, rect)
        
        
        CGContextAddPath(context, CGPathCreateWithRect(squareRect, nil))
        CGContextClip(context)
        CGContextClearRect(context, squareRect)
        
        
        CGContextAddPath(context, CGPathCreateWithRect(squareRect, nil))
        CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextStrokePath(context)
        
        //CGContextAddPath(context, <#T##path: CGPath?##CGPath?#>)

        //CGContextClip(context)
        
        //CGContextClip(context)
        
    }
}