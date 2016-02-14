//
//  TabBarVC.swift
//  CleverGarry
//
//  Created by Tony Parker on 1/7/16.
//  Copyright © 2016 Tony Parker. All rights reserved.
//

import Foundation
import UIKit


class TabBarVC : UITabBarController {
    
    var setupComplete = false
    
    
    override func viewDidLoad() {
        
        tabBar.items?[1].badgeValue = "2"
        tabBar.items?[3].badgeValue = "1"
        tabBar.items?[4].badgeValue = "1"
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if(!setupComplete){
            setupComplete = true
            performSegueWithIdentifier("setupGarry", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "setupGarry" {
            self.selectedIndex = 2
        }
    }
}