//
//  ModalVC.swift
//  CleverGarry
//
//  Created by Tony Parker on 1/4/16.
//  Copyright © 2016 Tony Parker. All rights reserved.
//

import Foundation
import UIKit
import RSBarcodes


class ModalVC : ViewController , UINavigationBarDelegate{
    
    @IBOutlet var spinner : UIImageView?
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.TopAttached
    }
    
    
    @IBAction func dismiss(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
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
    }
    
    @IBAction func showReader() {
    
        let reader = ScanVC()
        
        navigationController?.pushViewController(reader, animated: true)
    
    }
    
    @IBAction func popToRoot() {
        
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
}