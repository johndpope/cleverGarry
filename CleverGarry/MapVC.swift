//
//  MapVC.swift
//  CleverGarry
//
//  Created by Tony Parker on 1/21/16.
//  Copyright © 2016 Tony Parker. All rights reserved.
//

import Foundation
import UIKit
import Mapbox


class MapVC : ModalVC {
    
    
    @IBOutlet var mapView : MGLMapView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView?.styleURL = MGLStyle.lightStyleURL()
        let coordinate = CLLocationCoordinate2D.init(latitude: -33.8   ,longitude: 151.2789967835971 )
        mapView?.setCenterCoordinate(coordinate, zoomLevel: 12, animated: false)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func gotoSpeed(){
        
        NSNotificationCenter.defaultCenter().postNotificationName("showSpeedVC", object: self)
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