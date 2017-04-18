//
//  EventItem.swift
//  sendit
//
//  Created by Rohit Sharma on 4/5/17.
//  Copyright © 2017 Holly Haraguchi. All rights reserved.
//

import Foundation
import FirebaseAuthUI
import Firebase

struct EventItem {
    
    /*
     * key: ignore
     * name: description of event
     * timeString: date and time of event
     * location: location of event
     * ref: reference within the database. probably can just ignore
     * completed: ignore for now lel
     */
    let key: String
    let name: String
    let timeString: String
    let location: String
    let ref: FIRDatabaseReference?
    var completed: Bool
    
    init(name: String, timeString: String, location: String, completed: Bool, key: String = "") {
        self.key = key
        self.name = name
        self.timeString = timeString
        self.location = location
        self.completed = completed
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        timeString = snapshotValue["time"] as! String
        location = snapshotValue["location"] as! String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "time": timeString,
            "location": location,
            "completed": completed
        ]
    }
    
}
