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
    var jobList = [JenkinsJob]()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for custoization after application launch.
        application.registerUserNotificationSettings(
            UIUserNotificationSettings(
                forTypes: [.Alert, .Badge, .Sound],
                categories: nil))
        
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
        var request = NSURLRequest(URL: NSURL(string: "http://localhost:8080/api/json?pretty=true")!)
        var session = NSURLSession.sharedSession()


        var task = session.dataTaskWithRequest(request){ ( data, response, error) in
        
            do{
            if (error == nil){
                print("Response: \(response)")
                // var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                // print("Body: \(strData)")
                var json: NSDictionary =  try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary

                print("Jobs:")
                var jobs = json["jobs"] as? NSArray
                for job  in jobs! {
                    var  currentJob : JenkinsJob  = JenkinsJob(name: "")

                    print(job)
                    currentJob.name = job["name"] as! String

                    print(job["color"])
                    currentJob.status = job["color"] as! String

                    print(job["url"])
                    currentJob.url = job["url"] as! String

                    currentJob.lastupdate = NSDate()

                    if self.jobList.contains( currentJob){
                        print("Job exists")
                        var index = self.jobList.indexOf(currentJob)
                        self.jobList[ index! ].lastupdate = NSDate()

                    }else{
                        print("New job found")
                        self.jobList.append(currentJob)

                    }
                }
            }else{
                print( error )
            }
            }catch var serializationError as NSError{
                print(serializationError)
            }
        
        }

        task.resume()
        
    
        let okayAlertController:UIAlertController = UIAlertController(title: notification.alertAction, message: notification.alertBody, preferredStyle: .Alert)
        
        let alertAction: UIAlertAction = UIAlertAction(title: notification.alertAction, style: UIAlertActionStyle.Default, handler: { action in print("Click of cancel button" )
        } )
        
        okayAlertController.addAction(alertAction)
        
        let vController = self.window?.rootViewController
        
        vController?.presentViewController(okayAlertController, animated: true, completion: nil)
        

        
    }


}

