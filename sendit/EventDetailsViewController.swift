//
//  EventDetailsViewController.swift
//  sendit
//
//  Created by Holly Haraguchi on 4/18/17.
//  Copyright © 2017 Holly Haraguchi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI

class EventDetailsViewController: UIViewController {
    var event: EventItem!
    var ref = FIRDatabase.database().reference()
    let userID = FIRAuth.auth()?.currentUser?.uid

    @IBAction func setResponse(_ sender: Any) {
        ref.child("Users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let attending = value?["attending"] as? [Int]
            let eventId = event.eventId
            if attending.contains(eventId) {
                attending.remove(at: attending.index(of: eventId))
            }
            else {
                attending.append(eventId)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        ref.child("Users").child(userID!).setValue()
    }
    @IBOutlet weak var rsvpButton: UIButton!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        eventName.text = event.location
        dateLabel.text = event.dateTime
        detailsLabel.text = event.description
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
