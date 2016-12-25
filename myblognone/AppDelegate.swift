//
//  AppDelegate.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/18/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Fabric.with([Crashlytics.self])
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        setupNavigationBar()
        
        NewsListWireFrame.setNewsListInterface(to: window ?? UIWindow(frame: UIScreen.main.bounds))
        return true
    }
    
    private func setupNavigationBar() {
         UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont.fontForNavigationBarTitle()]
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
    }

}

