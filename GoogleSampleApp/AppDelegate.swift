//
//  AppDelegate.swift
//  GoogleSampleApp
//
//  Created by Brian D Keane on 9/11/16.
//  Copyright © 2016 Brian D Keane. All rights reserved.
//

import UIKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.setupGoogleSignIn()
        return true
    }
    
    func setupGoogleSignIn()
    {
        // Override point for customization after application launch.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().clientID = GOOGLE_CLIENT_ID
        GIDSignIn.sharedInstance().serverClientID = GOOGLE_SERVER_CLIENT_ID
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/userinfo.profile")
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/userinfo.email")
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/contacts.readonly")
    }
    
    //------------------------------------------------------------------------------
    // GIDSignInDelegate
    //------------------------------------------------------------------------------
    
    func application(application: UIApplication,
                     openURL url: NSURL, options: [String: AnyObject]) -> Bool
    {
        return GIDSignIn.sharedInstance().handleURL(url,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsAnnotationKey] as? String)
    }
    
    //------------------------------------------------------------------------------
    
    func application(application: UIApplication,
                     openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool
    {
        let options: [String: AnyObject] = [UIApplicationOpenURLOptionsSourceApplicationKey: sourceApplication!,
                                            UIApplicationOpenURLOptionsAnnotationKey: annotation]
        return self.application(application,
                                openURL: url,
                                options: options)
    }
    
    //------------------------------------------------------------------------------
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!)
    {
        if (error == nil)
        {
            print("sign in successful")
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    //------------------------------------------------------------------------------
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
        // Perform any operations when the user disconnects from app here.
        // ...
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

