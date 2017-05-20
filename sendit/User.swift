//
//  User.swift
//  sendit
//
//  Created by Rohit Sharma on 4/12/17.
//  Copyright © 2017 Holly Haraguchi. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuthUI

struct User {
    
    let key : String
    var uid: String
    var email: String
    var attending: [EventItem] = []
    var attended: [EventItem] = []
    var gender: String
    var birthday: String
    let ref: FIRDatabaseReference?
    
    init(uid: String, authData: FIRUser, email: String, attending: [EventItem], attended: [EventItem], gender: String, birthday: String, key: String = "") {
        self.uid = authData.uid
        self.email = authData.email!
        self.attending = attending
        self.attended = attended
        self.gender = gender
        self.birthday = birthday
        self.key = key
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        uid = snapshotValue["userID"] as! String
        email = snapshotValue["email"] as! String
        attending = snapshotValue["attending"] as! [EventItem]
        attended = snapshotValue["attended"] as! [EventItem]
        gender = snapshotValue["gender"] as! String
        birthday = snapshotValue["birthday"] as! String
        ref = snapshot.ref
    }
    
}

