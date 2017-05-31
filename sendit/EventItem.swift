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
     * description: description of event
     * dateTime: date and time of event
     * location: location of event
     * ref: reference within the database. probably can just ignore
     * completed: ignore for now lel
     */
    let key: String
    let description: String
    let dateTime: String
    let location: String
    let ref: FIRDatabaseReference?
    var completed: Bool
    var attending : [User] = []
    var eventId : String
    
    init(description: String, dateTime: String, location: String, completed: Bool, eventId: String, key: String = "") {
        self.key = key
        self.description = description
        self.dateTime = dateTime
        self.location = location
        self.completed = completed
        self.eventId = eventId
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        description = snapshotValue["name"] as! String
        dateTime = snapshotValue["time"] as! String
        location = snapshotValue["location"] as! String
        completed = snapshotValue["completed"] as! Bool
        eventId = snapshotValue["eventId"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": description,
            "time": dateTime,
            "location": location,
            "completed": completed,
            "eventId": eventId
        ]
    }
    
}
