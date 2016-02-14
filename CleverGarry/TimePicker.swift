//
//  TimePicker.swift
//  CleverGarry
//
//  Created by Tony Parker on 1/14/16.
//  Copyright © 2016 Tony Parker. All rights reserved.
//

import Foundation
import UIKit

class TimePicker : UIView {
    
    
    @IBOutlet var textLabel : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
       
    }
    
    
    var startHour : AnyObject? { return  NSUserDefaults.standardUserDefaults().objectForKey("startHour") }
    var endHour : AnyObject? { return NSUserDefaults.standardUserDefaults().objectForKey("endHour") }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        
        if startHour != nil {
            updateStartHour(startHour!.doubleValue)
        } else {
            updateStartHour(1)
            NSUserDefaults.standardUserDefaults().setDouble(1, forKey: "startHour")
        }
        
        if endHour != nil {
            updateEndHour(endHour!.doubleValue)
        } else {
            updateEndHour(5)
            NSUserDefaults.standardUserDefaults().setDouble(5, forKey: "endHour")
        }
        
        updateText()
    }
    
    let degreesPerHour = 360 / 24.0;
    
    let degreeRotation = 90.0
    
    var dialCenter : CGPoint {
        return CGPointMake(centerX, centerY)
    }
    
    var centerX : CGFloat {
        return self.frame.size.width * CGFloat(0.5)
    }
    
    var centerY : CGFloat {
        return self.frame.size.height * CGFloat(0.5)
    }
    
    var radius : CGFloat {
        return dialRect.width * CGFloat(0.5)
    }
    
    var dialRect : CGRect {
        return CGRectInset(self.bounds, pinSize.height, pinSize.height)
    }
    
    let lineWidth = CGFloat(11.0)
    let pinSize = CGSize(width: 10, height: 20)
    let pinRadius = CGFloat(5)
    
    var startDegree = CGFloat(0.0) {
        didSet {
            self.setNeedsDisplay()
        }
    }
    var endDegree = CGFloat(180.0) {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var holdingEnd = false
    var holdingStart = false
    var swapped = false
    
    var startAngleRadians : CGFloat {
        return (startDegree * CGFloat(M_PI)/180.0)
    }
    
    var endAngleRadians : CGFloat {
        return (endDegree * CGFloat(M_PI)/180.0)
    }
    
    var startHandlePosition : CGPoint {
        return pointFromCenterForDegree(dialCenter, degree: startDegree)
    }
    
    var endHandlePosition : CGPoint {
        return pointFromCenterForDegree(dialCenter, degree: endDegree)
    }
    
    var clockwise = Int32(1)
    
    func pointFromCenterForDegree(center : CGPoint, degree : CGFloat) -> CGPoint {
        
        let radian = (degree / 180) * CGFloat(M_PI)
        let x = cos(radian) * (radius+(pinSize.height-pinRadius))
        let y = sin(radian) * (radius+(pinSize.height-pinRadius))
        
        /*
        if (degree > 0 && degree < 180) {
            y *= -1
        }
        
        if (degree > 90 && degree < 270) {
            x *= -1
        }*/
        
        return CGPointMake(center.x + x, center.y + y)
    }
    
    override func drawRect(rect: CGRect) {
        
        updateText()
        
        let context = UIGraphicsGetCurrentContext()
        CGContextClearRect(context, rect)
        
        
        
        CGContextSetLineWidth(context, lineWidth)
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        CGContextAddArc(context, centerX, centerY, radius-(lineWidth*CGFloat(0.5)),
            startAngleRadians, endAngleRadians,clockwise)
        CGContextStrokePath(context)
        
        
        let radarImage = UIImage(imageLiteral: "dial.png")
        //radarImage.drawInRect(rect)
        CGContextDrawImage(context, dialRect, radarImage.CGImage)
        
        let startCircleRect = CGRectMake(startHandlePosition.x-pinRadius, startHandlePosition.y-pinRadius, pinRadius*2, pinRadius*2)
        CGContextAddEllipseInRect(context, startCircleRect)
      
        
        let endCircleRect = CGRectMake(endHandlePosition.x-pinRadius, endHandlePosition.y-pinRadius, pinRadius*2, pinRadius*2)
        CGContextAddEllipseInRect(context, endCircleRect)
        
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextFillPath(context)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let position = touch.locationInView(self)
            let startDistance = hypot(startHandlePosition.x - position.x, startHandlePosition.y - position.y)
            let endDistance = hypot(endHandlePosition.x - position.x, endHandlePosition.y - position.y)
            
            if startDistance > 60 && endDistance > 60 {
                return
            }
            
            if startDistance < endDistance {
                NSLog("Grab start at %i, %i", startHandlePosition.x, startHandlePosition.y)
                holdingStart = true
                holdingEnd = false
            } else {
                NSLog("Grab end at %i, %i", endHandlePosition.x, endHandlePosition.y)
                holdingEnd = true
                holdingStart = false
            }
            
            break;
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        commitTouches()
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        commitTouches()
    }
    
    func commitTouches() {
        holdingStart = false
        holdingEnd = false
        swapped = false
        
        let startHour = hourForDegree(Double(startDegree))
        let endHour = hourForDegree(Double(endDegree))
        
        startDegree = degreeForHour(startHour)
        endDegree = degreeForHour(endHour)
        
        NSUserDefaults.standardUserDefaults().setDouble(startHour, forKey: "startHour")
        NSUserDefaults.standardUserDefaults().setDouble(endHour, forKey: "endHour")
        
        updateText()
    }

    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if !holdingEnd && !holdingStart {
            return
        }
        
        updateText()
        
        for touch in touches {
            let position = touch.locationInView(self)
            let triangleSides =  CGSizeMake(
                position.x - (self.frame.size.width/2),
                position.y - (self.frame.size.height/2))
            
            let radian = atan2(triangleSides.height, triangleSides.width)
            
            
            var degree = CGFloat(radian)  * CGFloat(180.0 / M_PI)
            degree = degree > 0 ? degree : (360.0+degree)
            
            if holdingStart {
                /*
                if(startDegree < endDegree && degree >= endDegree){
                    swapped = true
                } else if (startDegree > endDegree && degree <= endDegree) {
                    swapped = true
                } else {
                    swapped = false
                }*/
                
                if(swapped){
                    holdingStart = false
                    holdingEnd = true
                    startDegree = endDegree
                    endDegree = degree
                } else {
                    startDegree = degree
                }
            }
            
            if holdingEnd {
                
                /*
                if(endDegree < startDegree && degree >= startDegree) {
                    swapped = true;
                } else if (endDegree > startDegree && degree <= startDegree) {
                    swapped = true;
                } else {
                    swapped = false
                }*/
                
                if(swapped){
                    holdingStart = true
                    holdingEnd = false
                    endDegree = startDegree
                    startDegree = degree
                } else {
                    endDegree = degree
                }
            }
            
            NSLog("Degree %f Hour %f", degree, hourForDegree(Double(degree)))
            
            /*
            if swapped == false && startDegree > endDegree-5 && startDegree < endDegree+5  {
                holdingStart = !holdingStart
                holdingEnd = !holdingEnd
                swapped = true
            } else if startDegree < endDegree-25 || startDegree > endDegree+25 {
                swapped = false
            }*/
            
            
            break
        }
    }
    
    func hourForDegree(input : Double) -> Double {

        var adjustedDegree = input - (360 - degreeRotation)
        if adjustedDegree < 0 {
            adjustedDegree += 360
        }
        
        return adjustedDegree / degreesPerHour
    }
    
    func degreeForHour(hour : Double) -> CGFloat {
        
        var degree = ((360 - degreeRotation) + Double(Int(hour) * Int(degreesPerHour)))
        
        if degree > 360 {
            degree -= 360
        }
        
        return CGFloat(degree)
    }
    
    func stringForHour(hour : Double) -> String {
        
        let timeOfDay = hour < 12 ? "AM" : "PM"
        
        var finalHour = hour < 12 ? hour : hour-12
        
        if finalHour == 0 || Int(finalHour) == 0 {
            finalHour = 12
        }
        
        return Int(finalHour).description + timeOfDay
    }
    
    func updateStartHour(hour : Double) {
        startDegree = degreeForHour(hour)
    }
    
    func updateEndHour(hour : Double){
        endDegree = degreeForHour(hour)
    }
    
    func updateText() {
        
        if startHour != nil && endHour != nil {
            let hourEnd = stringForHour(hourForDegree(Double(startDegree)))
            let hourStart = stringForHour(hourForDegree(Double(endDegree)))
        textLabel?.text = ("Alert Me When Driving Between " + hourStart + " & " + hourEnd)
        }
    }
    
    
}