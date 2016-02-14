//
//  AlertVC.swift
//  CleverGarry
//
//  Created by Tony Parker on 1/4/16.
//  Copyright © 2016 Tony Parker. All rights reserved.
//

import Foundation
import UIKit
import Mapbox

class AlertVC : ModalVC {

    @IBOutlet var mapView : MGLMapView?
    var long = 151.2789967835971
    var lat = -33.8
    var zoom = Double(16)
    
    
    override func viewDidLoad() {
        
        mapView?.styleURL = MGLStyle.lightStyleURL()
        let coordinate = CLLocationCoordinate2D.init(latitude: lat   ,longitude: long )
        mapView?.setCenterCoordinate(coordinate, zoomLevel: zoom, animated: false)
    }
    
}