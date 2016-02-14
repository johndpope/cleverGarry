//
//  GuidelineVC.swift
//  CleverGarry
//
//  Created by Tony Parker on 1/9/16.
//  Copyright © 2016 Tony Parker. All rights reserved.
//

import Foundation
import UIKit


class GuidelineVC : ModalVC {
    
    
    var opens = 0
    
    override func viewWillAppear(animated: Bool) {
        
        if opens == 0 {
            performSegueWithIdentifier("guideWarn", sender: self)
        }
        
        opens++
        
    }
    

    
}