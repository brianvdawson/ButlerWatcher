//
//  ViewController.swift
//  ButlerWatcher
//
//  Created by Brian on 10/5/15.
//  Copyright © 2015 Cloudbees. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func handleTouchUpInside(sender: UIButton) {
                 //---- create the notification
        let notification: UILocalNotification = UILocalNotification()
        
                //---- set the fire date (the date time in which it will fire)
                //notification.fireDate = NSDate(timeIntervalSinceNow: Double(60))
                
                //---- configure the alert stuff
                notification.alertAction = "View Alert"
                notification.alertBody = "Your 15 second alert has fired!"
                notification.alertTitle = "Title"
                
                //---- modify the badge
                notification.applicationIconBadgeNumber = 1;
                
                //---- set the sound to be the default sound
                notification.soundName = UILocalNotificationDefaultSoundName
                
                //---- schedule it
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
 
    }
 
    @IBAction func b(sender: AnyObject) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

