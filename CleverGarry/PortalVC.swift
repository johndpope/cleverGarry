//
//  PortalVC.swift
//  CleverGarry
//
//  Created by com1 on 1/31/16.
//  Copyright © 2016 Tony Parker. All rights reserved.
//

import Foundation
import UIKit
import RSBarcodes


class PortalVC : ViewController , UINavigationBarDelegate{
    
    @IBOutlet var spinner : UIImageView?

    override func viewWillAppear(animated: Bool) {
        if spinner != nil {
            
            let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotation.fromValue = 0.0
            rotation.duration = 2
            rotation.repeatCount = 10000000
            rotation.cumulative = true
            rotation.toValue = NSNumber(double: (M_PI * 2.0))
            
            spinner!.layer.addAnimation(rotation, forKey: "Rotation")
        }
        
        self.navigationItem.hidesBackButton = true
    }

    @IBAction func popToRoot() {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
}