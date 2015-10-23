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
        //create the notification
        let notification: UILocalNotification = UILocalNotification()
        //set the fire date (the date time in which it will fire)
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

    func displayJobs(){
        var jobButtons = [UIButton]()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

        var offset = CGFloat(0)
        appDelegate.jobsList.forEach { job  in
            var jobToggle = UISwitch( frame: CGRect( x: 200, y: 100 + offset, width: 100,  height: 100 ))
            var jobButton = UIButton( type: UIButtonType.System) as UIButton

            jobButton.frame = CGRectMake(100, 100 + offset, 100, 50)
            jobButton.backgroundColor = UIColor.greenColor()
            jobButton.setTitle( job.name, forState: UIControlState.Normal)
            jobButton.sizeToFit()

            self.view.addSubview(jobButton)
            self.view.addSubview(jobToggle)
            offset += 160

            self.view.setNeedsDisplay()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

