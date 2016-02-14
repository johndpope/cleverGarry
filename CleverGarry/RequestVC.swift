//
//  RequestVC.swift
//  CleverGarry
//
//  Created by com1 on 1/31/16.
//  Copyright © 2016 Tony Parker. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class RequestVC : UIViewController, UITextFieldDelegate, UITextViewDelegate, NIDropDownDelegate {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var kudos: UIButton!
    @IBOutlet var time: UIButton!
    @IBOutlet var kudosdropdown: UIImageView!
    @IBOutlet var timedropdown: UIImageView!
    
    @IBOutlet var comment: UITextView!
    
    var kudosDropDown: NIDropDown?
    var timeDropDown: NIDropDown?
    
    override func viewWillAppear(animated: Bool) {
        firstName.keyboardType = .Default
        firstName.attributedPlaceholder = NSAttributedString(string: "Sponsor's First Name", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        
        lastName.keyboardType = .Default
        lastName.attributedPlaceholder = NSAttributedString(string: "Sponsor's Last Name", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        
        email.keyboardType = .Default
        email.attributedPlaceholder = NSAttributedString(string: "Sponsor's Email Address", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        
        kudos.layer.cornerRadius = 6.0
        time.layer.cornerRadius = 6.0
        kudosDropDown?.layer.cornerRadius = 6.0
        timedropdown.layer.cornerRadius = 6.0
    }
    
    @IBAction func showResult(sender: AnyObject) {
        let amount = kudos.titleLabel?.text
        var CASHamount: String = ""
        var KUDOStotal: String = ""
        if amount == "$2.50 (250 Kudos)" {
            CASHamount = "2.50"
            KUDOStotal = "250"
        }
        else if amount == "$5 (500 Kudos)" {
            CASHamount = "5"
            KUDOStotal = "500"
        }
        else if amount == "$10 (1000 Kudos)" {
            CASHamount = "10"
            KUDOStotal = "1000"
        }
        else if amount == "$15 (1500 Kudos)" {
            CASHamount = "15"
            KUDOStotal = "1500"
        }
        else if amount == "$20 (2000 Kudos)" {
            CASHamount = "20"
            KUDOStotal = "2000"
        }
        else if amount == "$25 (2500 Kudos)" {
            CASHamount = "25"
            KUDOStotal = "2500"
        }
        else if amount == "$50 (5000 Kudos)" {
            CASHamount = "50"
            KUDOStotal = "5000"
        }
        
        let timePeriod = time.titleLabel?.text
        var discreteTime: String = ""
        if timePeriod == "Weekly" {
            discreteTime = "Week"
        }
        else if timePeriod == "Monthly" {
            discreteTime = "Month"
        }

        let commentBody: String = comment.text
        
        if firstName.text == "" || lastName.text == "" || email.text == "" || amount == "Wager" || commentBody == "" {
            return
        }

        let path: NSString = NSBundle.mainBundle().pathForResource("emailHTML", ofType: "html")!
        let str: String = path as String
        var content: String! = ""
        do {
            content = try String(contentsOfFile:str, encoding: NSUTF8StringEncoding)
        } catch _ as NSError { }

        content = content.stringByReplacingOccurrencesOfString("[firstName]", withString: firstName.text!)
        content = content.stringByReplacingOccurrencesOfString("[CASHamount]", withString: CASHamount)
        content = content.stringByReplacingOccurrencesOfString("[discreteTime]", withString: discreteTime)
        content = content.stringByReplacingOccurrencesOfString("[KUDOStotal]", withString: KUDOStotal)
        content = content.stringByReplacingOccurrencesOfString("[commentBody]", withString: commentBody)

        let sendGrid: SendGrid! = SendGrid(apiUser: "eddydevelops", apiKey: "Eddy1xcode")
        let sendEmail: SendGridEmail = SendGridEmail();
        
        sendEmail.to = email.text
        sendEmail.from = "kudos@clevergarry.com"
        sendEmail.fromName = "KUDOS from Clever Garry"
        sendEmail.subject = firstName.text! + ", John Jr can Drive!"
        sendEmail.text = "This email does not support text just yet"
        sendEmail.html = content
        
        sendGrid.sendWithWeb(sendEmail)
        
        self.performSegueWithIdentifier("requestKudos", sender: self)
    }
    
    @IBAction func kudosSelect(sender: AnyObject) {
        let items = ["$2.50 (250 Kudos)", "$5 (500 Kudos)", "$10 (1000 Kudos)", "$15 (1500 Kudos)", "$20 (2000 Kudos)", "$25 (2500 Kudos)", "$50 (5000 Kudos)", "Wager"];
        
        if kudosDropDown == nil {
            let f: CGFloat = 120
            kudosDropDown = NIDropDown().showDropDown(sender as! UIButton, f, items, nil, "down") as? NIDropDown
            kudosDropDown!.delegate = self
        }
        else {
            kudosDropDown!.hideDropDown(sender as! UIButton)
            kudosDropDown = nil
        }
    }
        
    @IBAction func timeselect(sender: AnyObject) {
        let items = ["Weekly", "Monthly"];
        
        if timeDropDown == nil {
            let f: CGFloat = 60
            timeDropDown = NIDropDown().showDropDown(sender as! UIButton, f, items, nil, "down") as? NIDropDown
            timeDropDown!.delegate = self
        }
        else {
            timeDropDown!.hideDropDown(sender as! UIButton)
            timeDropDown = nil
        }
    }
    
    func niDropDownDelegateMethod(sender: NIDropDown!) {
        let sel: String = sender!.selected
        
        if sel == "Wager" {
            time.hidden = true
            timedropdown.hidden = true
        }
        else {
            time.hidden = false
            timedropdown.hidden = false
        }
        
        kudosDropDown = nil
        timeDropDown = nil
    }
    
    @IBAction func startEditing(sender: AnyObject) {
        var rect: CGRect = self.contentView.frame
        
        rect.origin.y -= 100
        rect.size.height += 100
        self.view.frame = rect;
    }
    
    @IBAction func endEditing(sender: AnyObject)
    {
        var rect: CGRect = self.contentView.frame
    
        rect.origin.y += 100
        rect.size.height -= 100
        self.view.frame = rect;
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        var rect: CGRect = self.contentView.frame

        rect.origin.y -= 100
        rect.size.height += 100
        self.view.frame = rect;
        
        textView.text = ""
        
        return true
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        var rect: CGRect = self.contentView.frame

        rect.origin.y += 100
        rect.size.height -= 100
        self.view.frame = rect;
        
        if textView.text == "" {
            textView.text = "Coments (max 50 words)"
        }
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        email.resignFirstResponder()
        comment.resignFirstResponder()
    }
}
