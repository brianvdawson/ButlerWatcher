//
//  JobUtils.swift
//  ButlerWatcher
//
//  Created by Brian on 10/14/15.
//  Copyright © 2015 RedEye. All rights reserved.
//

import Foundation
import UIKit
import CoreImage

class JobUtils {
    var jobsList: [JenkinsJob]
    var url: NSURL

    init(jobsList: [JenkinsJob], url: NSURL) {
        self.jobsList = jobsList
        self.url = url
    }

    func readJobs( completion: [JenkinsJob] ->() ) {
        let request = NSURLRequest(URL: self.url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            data, response, error in

            if (error != nil){
                print(error)
                return
            }else {
                print("Response: \(response)")
                var json: NSDictionary

                do{
                    json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary

                    print("Jobs:")
                    var jobs = json["jobs"] as? NSArray
                    for job in jobs! {
                        var currentJob: JenkinsJob = JenkinsJob(name: "")

                        print(job)
                        currentJob.name = job["name"] as! String

                        print(job["color"])
                        currentJob.status = job["color"] as! String

                        print(job["url"])
                        currentJob.url = job["url"] as! String

                        currentJob.lastupdate = NSDate()

                        if self.jobsList.contains(currentJob) {
                            print("Job exists")
                            var index = self.jobsList.indexOf(currentJob)
                            self.jobsList[index!].lastupdate = NSDate()

                        } else {
                            print("New job found")
                            self.jobsList.append(currentJob)
                        }

                    }

                    completion( self.jobsList )
                }catch var serializationError as NSError{
                    print( serializationError.debugDescription )
                    return
                }
            }
        }
        task.resume()
    }

    func readJobsCompletionHandler(data: NSData?, response: NSURLResponse?, error: NSError?) {
        do {
            if (error != nil){
                print(error)

            }else{

            }


        }catch var serializationError as NSError {
            print(serializationError)
        }

    }

    func createJobsView( jobsList: [JenkinsJob], view: UIView ) -> UIView {
        let labelHeight: CGFloat = 50
        let toggleHeight: CGFloat = labelHeight
        let labelWidth: CGFloat = 150
        let toggleWidth: CGFloat = 50
        let elementOrigin: CGPoint = CGPoint(x: 10, y: 10)


        let labelRect: CGRect = CGRect(origin: elementOrigin, size: CGSize(width: labelWidth, height: labelHeight))
        let toggleRect: CGRect = CGRect( x: elementOrigin.x  + labelWidth + 10 , y: elementOrigin.y, width: toggleWidth, height: toggleHeight)

        var jobOffset = CGFloat(0)

        for (index, job ) in  jobsList.enumerate( ){
            jobOffset += CGFloat( 70 * index )
            var jobView: UIView = UIView( frame: CGRect(x: 10, y: 100 + jobOffset, width: 230, height: 70) )
            jobView.backgroundColor = UIColor.lightGrayColor()
            jobView.layer.cornerRadius = 5
            jobView.layer.borderWidth = 2
            //jobView.layer.borderColor = CGColor .darkGrayColor()

            var jobLabel: UILabel = UILabel()

            jobLabel.frame = labelRect
            jobLabel.text = job.name
            jobView.layer.cornerRadius = 5
            jobLabel.backgroundColor = statusToColor( job.status )
            jobLabel.textAlignment = NSTextAlignment.Center
            jobView.addSubview(jobLabel)

            var jobToggle = UISwitch(frame: toggleRect )
            jobView.addSubview(jobToggle)

            if jobView.isDescendantOfView(view) {
                print( "view already exists")
            }else{

                view.addSubview(jobView)
                jobView.setNeedsDisplay()
            }
        }
        return view
    }

    func statusToColor( status: NSString ) -> UIColor {
        var color: UIColor

        switch status {
            case  "blue":
                color = UIColor.blueColor()

            case "red":
                color = UIColor.redColor()
            default:
                color = UIColor.grayColor()
        }
        return color
    }
}







