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
import ForceUpdateSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let iTunesID = "1191248877"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Fabric.with([Crashlytics.self])
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        setupForceUpdate()
        setupNavigationBar()
        setupStatusBar()
        
        NewsListWireFrame.setNewsListInterface(to: window ?? UIWindow(frame: UIScreen.main.bounds))
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
        FUSManager.sharedInstance().checkLatestAppStoreVersion()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
    }
    
    private func setupStatusBar() {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    private func setupNavigationBar() {
        UINavigationBar.appearance().barTintColor = UIColor(hexString: UIColor.navigationBarBackground)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [
            NSFontAttributeName: UIFont.fontForNavigationBarTitle(),
            NSForegroundColorAttributeName: UIColor.white
        ]
    }
    
    private func setupForceUpdate() {
        FUSManager.sharedInstance().itunesId = iTunesID
//        FUSManager.sharedInstance().debugMode = true
    }

}

