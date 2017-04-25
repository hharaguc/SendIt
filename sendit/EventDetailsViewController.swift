//
//  EventDetailsViewController.swift
//  sendit
//
//  Created by Holly Haraguchi on 4/18/17.
//  Copyright © 2017 Holly Haraguchi. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {
    var event: EventItem!
    
    @IBAction func setResponse(_ sender: UIButton) {
    }

    @IBOutlet weak var rsvpButton: UIButton!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        eventName.text = event.location
        dateLabel.text = event.timeString
        detailsLabel.text = event.name
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
