//
//  AppDelegate.swift
//  CleverGarry
//
//  Created by Tony Parker on 1/2/16.
//  Copyright © 2016 Tony Parker. All rights reserved.
//

import UIKit
import QuartzCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        setAppearance()
        
        let image = UIImage(named: "ImageBlurred")!
        
        window!.layer.contents = image.CGImage
        //window!.backgroundColor = UIColor(patternImage: image)
        

        return true
    }
    
    func setAppearance() {
        
        let bounds = CGRectMake(0, 0, window!.bounds.width, 40)
        let gradient = CAGradientLayer.gradientLayerForBounds(bounds)
        
        UIGraphicsBeginImageContext(gradient.bounds.size)
        gradient.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        
        UINavigationBar.appearance().setBackgroundImage(image, forBarMetrics: UIBarMetrics.Default)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().translucent = false
        
    
        
        NSLog("%@", UIFont.fontNamesForFamilyName("Open Sans"))
        var textAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName : UIFont(name: "OpenSans-Semibold", size: 18.0)!]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        
        textAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName : UIFont(name: "Open Sans", size: 18.0)!]
        UIBarButtonItem.appearance().setTitleTextAttributes(textAttributes, forState: UIControlState.Normal)
        
        
        textAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName : UIFont(name: "Open Sans", size: 12.0)!]
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        UITabBarItem.appearance().setTitleTextAttributes(textAttributes, forState: UIControlState.Normal)
        
        textAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName : UIFont(name: "OpenSans-Bold", size: 12.0)!]
        UITabBarItem.appearance().setTitleTextAttributes(textAttributes, forState: UIControlState.Highlighted)
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    

}

