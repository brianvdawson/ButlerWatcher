//
//  AppDelegate.swift
//  ButlerWatcher
//
//  Created by Brian on 10/5/15.
//  Copyright © 2015 Cloudbees. All rights reserved.
//

import UIKit
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var jobsList: [JenkinsJob]
    var hostURL: NSURL

    override init(){
        jobsList =  [JenkinsJob]()
        hostURL = NSURL( string: "")!
        super.init()
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for custoization after application launch.
        application.registerUserNotificationSettings(
            UIUserNotificationSettings(
                forTypes: [.Alert, .Badge, .Sound],
                categories: nil))
        
        
        //let defaults = NSUserDefaults.standardUserDefaults()
        let urlPref = NSUserDefaults.standardUserDefaults().valueForKey("jenkins_url") as? String
        if urlPref == nil{
            print("Preferences are empty")
        }else{
            self.hostURL = NSURL( string: urlPref! )!
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
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        print("Recieved Local Notification")
        let viewCtrl = self.window?.rootViewController
        let jobUtils = JobUtils( jobsList: self.jobsList, url:  hostURL )
        
        //Update Jobs
        ///Read Jobs from host
        jobUtils.readJobs{
           foundJobs in
            self.jobsList = foundJobs
            //Create UI elements for jobs and draw
            viewCtrl!.view = jobUtils.createJobsView(  self.jobsList, view: viewCtrl!.view! )
            viewCtrl!.view.setNeedsDisplay()
        }


      /*  let okayAlertController:UIAldertController = UIAlertController(title: notification.alertAction, message: notification.alertBody, preferredStyle: .Alert)
        
        let alertAction: UIAlertAction = UIAlertAction(title: notification.alertAction, style: UIAlertActionStyle.Default, handler: { action in print("Click of cancel button" )
        } )
        
        okayAlertController.addAction(alertAction)

        viewCtrl?.presentViewController(okayAlertController, animated: true, completion: nil)*/
    }
}

