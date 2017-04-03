//
//  BeaconTableViewController.swift
//  iRadar
//
//  Created by Rashiv Romio Bhusal on 3/4/17.
//  Copyright © 2017 Rashiv Romio Bhusal. All rights reserved.
//

import UIKit

class BeaconTableViewController: UITableViewController {
    

   var beacons = [Beacons]()
   
  //  var beacons = ["4tla", "rTJz", "oHdN"]
  
    let cellIdentifier = "BeaconTableViewCell"
    
    // =========================================================================
    // MARK: - UIViewController
   
    
    override func viewDidLoad() {
        // Super
        super.viewDidLoad()
        loadSampleBeacons()
        print("EHU")
        
        
        
    }

    
    //MARK: Private Methods
    
    private func loadSampleBeacons() {
        
        let photo1 = UIImage(named: "Beacons1")
        let photo2 = UIImage(named: "Beacons2")
        
        guard let Beacons1 = Beacons(name: "1st Beacon", photo: photo1) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let Beacons2 = Beacons(name: "2nd Beacon", photo: photo2) else {
            fatalError("Unable to instantiate meal2")
        }
        
         beacons += [Beacons1, Beacons2]
        
    }
    
    
        

    
  
    
    // =========================================================================
    // MARK: - Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beacons.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "BeaconTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BeaconTableViewCell  else {
            fatalError("The dequeued cell is not an instance of BeaconTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let beacon = beacons[indexPath.row]
        
        cell.nameLabel.text = beacon.name
        cell.photoImageView.image = beacon.photo
        
        return cell
    }
    
        
       // cell.textLabel?.text = "Beacons \(indexPath.section) Row \(indexPath.row)"
//        let row = indexPath.row
//        cell.textLabel?.text = beacons[row].name
//        //cell.textLabel?.textColor = UIColor.kontaktMainGray
//        cell.accessoryType = .disclosureIndicator
//

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Beacons \(section)"
    }
    
    
    private func loadBeacons() -> [Beacons]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Beacons.ArchiveURL.path) as? [Beacons]
   
    }
    
}
