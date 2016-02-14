//
//  TabBar.swift
//  CleverGarry
//
//  Created by Tony Parker on 1/10/16.
//  Copyright © 2016 Tony Parker. All rights reserved.
//

import Foundation
import UIKit

class TabBar: UITabBar {
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 68
        
        return sizeThatFits
    }
}