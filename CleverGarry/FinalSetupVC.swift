//
//  FinalSetupVC.swift
//  CleverGarry
//
//  Created by Tony Parker on 1/25/16.
//  Copyright © 2016 Tony Parker. All rights reserved.
//

import UIKit

class FinalSetupVC: ModalVC {

    
    @IBAction override func dismiss(){
        NSNotificationCenter.defaultCenter().postNotificationName("setSpeedFirstTime", object: self)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
