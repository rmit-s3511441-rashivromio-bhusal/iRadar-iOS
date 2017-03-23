//
//  ViewController.swift
//  iRadar
//
//  Created by Rashiv Romio Bhusal on 23/3/17.
//  Copyright © 2017 Rashiv Romio Bhusal. All rights reserved.
//

import UIKit

class BeaconsViewController: UITableViewController {
    
    var beacons:[Beacons] = beaconsData
    
    // MARK: - Table view data source
    
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beacons.count
    }
    
    
 func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BeaconsCell", for: indexPath as IndexPath)
                as! BeaconsCell

            
           let beacons = self.beacons[indexPath.row] as Beacons
            cell.beacons = beacons
            return cell
    }
    
}



