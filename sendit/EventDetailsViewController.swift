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
    let userID = FIRAuth.auth()?.currentUser?.uid
    let ref = FIRDatabase.database().reference(withPath: "sendit/Users")
    var attending: [String] = []
    
    @IBOutlet weak var rsvpButton: UIButton!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBAction func setResponse(_ sender: Any) {
        // Variables for array find and remove functions
        var matchFound = false
        var idx = 0
        
        let eventId = self.event.eventId
        
        /* Get the snapshot of the user object */
        ref.child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.attending = (value?["attending"] as? [String])!
            
            /* 
             * Iterate over the events the user is currently RSVP'd for.
             * If the current event's ID is found, save its position in the array and raise the 'matchFound' flag.
             */
            for curId in self.attending {
                if curId == eventId {
                    matchFound = true
                    break
                }
                idx += 1
            }
            
            /* Append/remove the event's ID to/from the attending array depending on their current RSVP response */
            if (!matchFound) {
                self.attending.append(eventId)
            }
            else {
                self.attending.remove(at: idx)
            }
            
            /* Update the "attending" field */
            self.ref.updateChildValues(["/\(self.userID!)/attending" : self.attending])
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        /* Toggle the button title */
        if let label = rsvpButton.title(for: .normal) {
            if label == "RSVP" {
                rsvpButton.setTitle("un-RSVP", for: .normal)
            }
            else {
                rsvpButton.setTitle("RSVP", for: .normal)
            }
        }
    }
    
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
