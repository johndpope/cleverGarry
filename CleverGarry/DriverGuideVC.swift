//
//  DriverGuideVC.swift
//  CleverGarry
//
//  Created by Tony Parker on 1/24/16.
//  Copyright © 2016 Tony Parker. All rights reserved.
//

import Foundation
import UIKit


class DriverGuideVC : UIViewController {
    
    @IBOutlet var timeLimit : UILabel?;
    
    
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showSpeedSetting", name: "setSpeedFirstTime", object: nil)
    }

    
    func showSpeedSetting(){
        
        NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "gotoSpeed", userInfo: nil, repeats: false)
    }
    
    func gotoSpeed(){
        
        performSegueWithIdentifier("gotoSpeed", sender: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        updateText()
        
        //quick nasty fix for bug:
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateText", userInfo: nil, repeats: true)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "seeMap"){
            let dest = segue.destinationViewController as! GuidelineSettingsVC
            
            dest.loadMapFirst = true
            
        }
        
    }
    

    
    override func dismissViewControllerAnimated(flag: Bool, completion: (() -> Void)?) {
        
        super.dismissViewControllerAnimated(flag) { () -> Void in
            self.updateText()
        }
    }
    
    func updateText() {
        

        var startHour = NSUserDefaults.standardUserDefaults().doubleForKey("startHour")
        var endHour = NSUserDefaults.standardUserDefaults().doubleForKey("endHour")
        
        if startHour == 0 {
            NSUserDefaults.standardUserDefaults().setDouble(5, forKey: "startHour")
            startHour = 5
        }
   
        if endHour == 0 {
            NSUserDefaults.standardUserDefaults().setDouble(1, forKey: "endHour")
            endHour = 1
        }
        
    
        startHour = NSUserDefaults.standardUserDefaults().doubleForKey("startHour")
        endHour = NSUserDefaults.standardUserDefaults().doubleForKey("endHour")
        
        let hourEnd = stringForHour(startHour)
        let hourStart = stringForHour(endHour)
        timeLimit?.text = (hourStart + " & " + hourEnd)
        
    }

    
    func stringForHour(hour : Double) -> String {
        
        let timeOfDay = hour < 12 ? "AM" : "PM"
        
        var finalHour = hour < 12 ? hour : hour-12
        
        if finalHour == 0 || Int(finalHour) == 0 {
            finalHour = 12
        }
        
        return Int(finalHour).description + timeOfDay
    }
    
}