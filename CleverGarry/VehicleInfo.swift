//
//  VehicleInfo.swift
//  CleverGarry
//
//  Created by Tony Parker on 1/9/16.
//  Copyright © 2016 Tony Parker. All rights reserved.
//

import Foundation
import UIKit

class VehicleInfo : UIViewController {
    
    var opens = 0
    
    override func viewWillAppear(animated: Bool) {
        
        navigationController?.tabBarItem.badgeValue = nil
        
        if opens == 0 {
            performSegueWithIdentifier("vehicleWarn", sender: self)
        }
        
        opens++
        
    }
    
}