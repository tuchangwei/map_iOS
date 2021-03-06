//
//  AppDelegate.swift
//  Map
//
//  Created by vale on 4/2/15.
//  Copyright (c) 2015 changweitu@app660.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //Power your app with local database.
        Parse.enableLocalDatastore()
        
        //Initialize Parse.
        Parse.setApplicationId("5wyfBMwoiJwgutMg9XX1FvhvXSYxAwu8vXxynyNT", clientKey: "ZtlhmvsKJ4wQLeGJBEuDits257wygWrEFkmeRgje")
        PFFacebookUtils.initializeFacebook()
        PFTwitterUtils.initializeWithConsumerKey("bzX9zPp5sF3ntHSiImcjrOAzb", consumerSecret: "B5KELNtkzIS1SjBAV1WHZ08rabAPM3WOKIVR4qGn9PHPbACD8q")
        //Track statistics around application opens
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: { (successed: Bool, error: NSError!) -> Void in
            
        })

        
        UINavigationBar.appearance().barTintColor = UIColor(red: 67.0/255.0, green: 129.0/255.0, blue: 251.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()
        //set the status bar white
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        
        if (url.absoluteString?.hasPrefix("fb479622788854624:") != nil) {
            
            return FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication, withSession: PFFacebookUtils.session())
        }
        return true
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
        FBAppCall.handleDidBecomeActiveWithSession(PFFacebookUtils.session())
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        PFFacebookUtils.session().close()
    }


}

