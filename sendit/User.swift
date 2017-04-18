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
    
    let uid: String
    let email: String
    var type: String?
    
    
    init(authData: FIRUser) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
}

