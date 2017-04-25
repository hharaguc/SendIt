//
//  EventViewController.swift
//  sendit
//
//  Created by Holly Haraguchi on 3/12/17.
//  Copyright © 2017 Holly Haraguchi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI

class EventViewController: UITableViewController {
    
    var items: [EventItem] = []
    var ref = FIRDatabase.database().reference(withPath: "sendit/Events")
    let usersRef = FIRDatabase.database().reference(withPath: "online")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsMultipleSelectionDuringEditing = false
        
        ref.observe(.value, with: { snapshot in
            var newItems: [EventItem] = []
            
            for item in snapshot.children {
                let uploadedItem = EventItem(snapshot: item as! FIRDataSnapshot)
                newItems.append(uploadedItem)
            }
            
            self.items = newItems
            self.tableView.reloadData()
        })

    }
    
    // do the events in the Event table have a 'description' attribute? 
    // MARK: UITableView Delegate methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        let uploadedItem = items[indexPath.row]
        
        cell.textLabel?.text = uploadedItem.location
        cell.detailTextLabel?.text = uploadedItem.timeString
        
        //toggleCellCheckbox(cell, isCompleted: uploadedItem.completed)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEventDetailsSegue" {
            if let nextVC = segue.destination as? EventDetailsViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let event = items[indexPath.row]
                    nextVC.event = event
                }
            }
        }
    }
    
}

