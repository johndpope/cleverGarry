//
//  SpeedVC.swift
//  CleverGarry
//
//  Created by Tony Parker on 1/21/16.
//  Copyright © 2016 Tony Parker. All rights reserved.
//

import UIKit

class SpeedVC: ModalVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func gotoTime(){
        
        NSNotificationCenter.defaultCenter().postNotificationName("showTimeVC", object: self)
    }

    
    @IBAction func gotoMap(){
        
        NSNotificationCenter.defaultCenter().postNotificationName("showMapVC", object: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
