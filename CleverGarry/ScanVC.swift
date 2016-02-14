//
//  ScanVC.swift
//  CleverGarry
//
//  Created by Tony Parker on 1/7/16.
//  Copyright © 2016 Tony Parker. All rights reserved.
//

import Foundation
import RSBarcodes
import UIKit
import MTBBarcodeScanner

class ScanVC : UIViewController {
    
    @IBOutlet var words : UIImageView?
    @IBOutlet var button : UIImageView?
    @IBOutlet var toggle : UIImageView?
    var thumb : UIImageView!
    var cover : UIView!
    var imageSuccess : UIImageView!
    var scanner : MTBBarcodeScanner!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if imageSuccess != nil {
            imageSuccess!.removeFromSuperview()
            thumb!.removeFromSuperview()
            cover!.removeFromSuperview()
        }
        
        if scanner == nil {
            scanner = MTBBarcodeScanner(previewView: self.view)
        }
        
        let rect = self.view.frame
        
        self.view.insertSubview(words!, atIndex: 3)
        
        self.view.insertSubview(words!, atIndex: 4)
        
        self.view.insertSubview(words!, atIndex: 5)
        
        let squareSize = CGSizeMake(rect.width * 0.80, rect.width * 0.80)
        let squareRect = CGRectMake(rect.width*0.1, rect.width*0.1, squareSize.width, squareSize.height)
        
        scanner.scanRect = CGRectMake(rect.width*0.1, rect.width*0.1, squareSize.width, squareSize.height)

        
        MTBBarcodeScanner.requestCameraPermissionWithSuccess { (success : Bool) -> Void in
            if(success){
                
                self.scanner.unfreezeCapture()
                self.scanner.startScanningWithResultBlock({ (codes : [AnyObject]!) -> Void in
                    let code = codes.first
                    
                    if code != nil {
                        NSLog("found %@", code!.description)
                    }
                    
                    self.scanner.freezeCapture()
                    
                    let imageRect = CGRectOffset(squareRect, 0, squareRect.size.height*0.2)
                    
                    self.imageSuccess = UIImageView(frame: imageRect)
                    self.imageSuccess.image = UIImage(imageLiteral: "Success!.png")
                    self.imageSuccess.contentMode = UIViewContentMode.Center
                    self.view.addSubview(self.imageSuccess)
                    
                    
                    self.thumb = UIImageView(frame: imageRect)
                    self.thumb.image = UIImage(imageLiteral: "thumbs28.png")
                    self.thumb.contentMode = UIViewContentMode.Top
                    self.view.addSubview(self.thumb)
                    
                    self.cover = UIView(frame: self.view.bounds)
                    self.cover.backgroundColor = UIColor(red: 23/255.0, green: 21/255.0, blue: 22/255.0, alpha: 1)
                    self.view.insertSubview(self.cover, atIndex: 1)
                    
                    let flash = UIView(frame: self.view.bounds)
                    flash.backgroundColor = UIColor.whiteColor()
                    self.view.addSubview(flash)
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        flash.alpha = 0
                        }, completion: { (success :Bool) -> Void in
                        flash.removeFromSuperview()
                    })
                    
                    self.performSelector("nextStep", withObject: self, afterDelay: 1.75)
                })
            }
        }
        
        let overlay = ScanOverlayView(frame:self.view.bounds)
        overlay.opaque = false
        //overlay.alpha = 0.5
        view.addSubview(overlay)
        
        
    }
    
    func nextStep() {
        
        performSegueWithIdentifier("nextStep", sender: self)
    }
    
}