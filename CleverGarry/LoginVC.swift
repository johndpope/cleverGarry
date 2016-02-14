//
//  LoginVC.swift
//  CleverGarry
//
//  Created by Tony Parker on 1/9/16.
//  Copyright © 2016 Tony Parker. All rights reserved.
//

import Foundation
import UIKit

class LoginVC : UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    @IBOutlet var emailInput : UITextField!
    @IBOutlet var passwordInput : UITextField!
    @IBOutlet var scrollView : UIScrollView!
    
    var flashView : UIView?
    
    
    override func viewDidLoad() {
        
        var str = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        emailInput.attributedPlaceholder = str
        
        str = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        passwordInput.attributedPlaceholder = str
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        flashView = UIView(frame: self.view.frame)
        flashView!.backgroundColor = UIColor(red: 197/255.0, green: 201/255.0, blue: 232/255.0, alpha: 1.0)
        self.view.addSubview(flashView!)
    }
    
    override func viewDidAppear(animated: Bool) {
        if flashView != nil {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.flashView!.alpha = 0
                }) { (success : Bool) -> Void in
                    self.flashView!.removeFromSuperview()
            }
        }
    }
    
    @IBAction func signIn() {
        
        if(emailInput!.text == "test@cametric.com" && passwordInput!.text == "Test") {
            performSegueWithIdentifier("loginSegue", sender: nil)
        }
        
        if(emailInput!.text == "a" && passwordInput!.text == "a") {
            performSegueWithIdentifier("loginSegue", sender: nil)
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        scrollView.scrollRectToVisible(CGRectMake(0, 50, 0, 0), animated: true)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        scrollView.scrollRectToVisible(CGRectZero, animated: true)
    }
    
}