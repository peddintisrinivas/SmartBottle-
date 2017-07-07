//
//  AppDelegate.swift
//  Smart Rod
//
//  Created by Srinivas Peddinti on 7/4/17.
//  Copyright © 2017 MobiwareInc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UIApplication.shared.isStatusBarHidden = true
        
        let fontFamilyNames = UIFont.familyNames

        print("Font Family Name = [\(fontFamilyNames)]")

        
        let userSignedIn =   UserDefaults.standard.bool(forKey: Constants.kUserSuccessfullySignedIn)
        
        if(userSignedIn == true)
        {
        
        }
        else
        {
            self.loadLogin()
        }
        return true
    }
    func loadLogin()
    {
        self.navigationController = UINavigationController()
        
        let loginController : UIViewController = LoginViewController(nibName:NibNamed.LoginViewController.rawValue, bundle:nil)
        self.navigationController!.pushViewController(loginController, animated: false)
        self.navigationController?.navigationBar.isHidden = true
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window!.rootViewController = navigationController
        
        self.window!.makeKeyAndVisible()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

