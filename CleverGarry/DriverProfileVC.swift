//
//  DriverProfileVC.swift
//  CleverGarry
//
//  Created by Tony Parker on 1/4/16.
//  Copyright © 2016 Tony Parker. All rights reserved.
//

import Foundation
import UIKit
import BBBadgeBarButtonItem


class DriverProfileVC : UIViewController {
    
    override func viewDidLoad() {
        /*
        let navButton = UIButton()
        let image = UIImage(imageLiteral: "topNav.png")
        navButton.setTitle("Slip-Ups", forState: UIControlState.Normal)
        navButton.setImage(image, forState: UIControlState.Normal)
        
        //navButton.setImage(image, forState: UIControlState.Normal)
        
        //let badgeButton = BBBadgeBarButtonItem(customUIButton: navButton)
        let b = UIBarButtonItem(customView: navButton)
        //badgeButton.badgeValue = "2"
        
        
        self.navigationItem.rightBarButtonItem = b
        
        navButton.addTarget(self, action: "openSlipUps", forControlEvents: UIControlEvents.TouchUpInside)*/
    }
    
    @IBAction func openSlipUps(){
        
        
        navigationController?.tabBarItem.badgeValue = nil

        performSegueWithIdentifier("slipupsModal", sender: self)
    }
   
    
}