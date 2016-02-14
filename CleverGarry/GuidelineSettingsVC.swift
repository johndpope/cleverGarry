//
//  GuidelineSettingsVC.swift
//  CleverGarry
//
//  Created by Tony Parker on 1/21/16.
//  Copyright © 2016 Tony Parker. All rights reserved.
//

import UIKit

class GuidelineSettingsVC: ModalVC {
    
    @IBOutlet var speedView : UIView?
    @IBOutlet var timeView : UIView?
    @IBOutlet var mapView: UIView?
    
    var loadMapFirst = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showMapView", name: "showMapVC", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showSpeedView", name: "showSpeedVC", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showTimeView", name: "showTimeVC", object: nil)
        
        if loadMapFirst {
            showMapView()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showMapView() {
        showView(mapView!)
    }
    
    @IBAction func showTimeView() {
        showView(timeView!)
    }
    
    @IBAction func showSpeedView(){
        showView(speedView!)
    }
    
    func showView(view : UIView){
        speedView?.hidden = true
        timeView?.hidden = true
        mapView?.hidden = true
        
        view.hidden = false
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
