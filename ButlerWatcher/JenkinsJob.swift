//
// Created by Brian on 10/17/15.
// Copyright (c) 2015 RedEye. All rights reserved.
//
import Foundation

class JenkinsJob : Equatable {
    var id: String?
    var name = ""
    var status = ""
    var url = "https:/localhost"
    var lastupdate = NSDate()
    var isMontitered = false
    var token =  ""

    init(name : String) {
        self.name = name
    }

}

func == (lhs: JenkinsJob, rhs: JenkinsJob) -> Bool {
    return lhs.name == rhs.name
}


