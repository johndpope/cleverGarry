//
//  LandingPageVC.swift
//  CleverGarry
//
//  Created by Tony Parker on 1/4/16.
//  Copyright © 2016 Tony Parker. All rights reserved.
//

import Foundation
import UIKit


class LandingPageVC : ViewController, UINavigationBarDelegate {
    
    @IBOutlet var background : UIImageView?
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = true
   
        
        UIView.animateWithDuration(0.5, delay: 0.5, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.background?.alpha = 1.0
            }, completion: nil)
    }
    
    
    
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        if(identifier == "parentLogin"){
            self.navigationController?.navigationBar.hidden = false
        }
        else if(identifier == "portal"){
            self.navigationController?.navigationBar.hidden = false
        }
        
        return true
    }
    
    @IBAction func portal(sender: AnyObject) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            //self.background?.alpha = 0.0
            self.navigationController?.navigationBarHidden = false
            }) { (success : Bool) -> Void in
                self.navigationController?.navigationBar.hidden = false
                self.performSegueWithIdentifier("portal", sender: self)
        }
    }
    
    @IBAction func parentLogin(){
        //self.navigationController?.navigationBar.hidden = false
        //self.performSegueWithIdentifier("parentLogin", sender: self)
        
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
                //self.background?.alpha = 0.0
            self.navigationController?.navigationBarHidden = false
            }) { (success : Bool) -> Void in
                self.navigationController?.navigationBar.hidden = false
                self.performSegueWithIdentifier("parentLogin", sender: self)
        }
    
    }
    
}

