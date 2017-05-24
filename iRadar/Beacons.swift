//
//  Beacons.swift
//  iRadar
//
//  Created by Rashiv Romio Bhusal on 3/4/17.
//  Copyright © 2017 Rashiv Romio Bhusal. All rights reserved.
//





import UIKit
import KontaktSDK

class Beacons: NSObject {
    
   
  
    var title: String?
    var desc: String?
    var img: String?
    
    
    
   // var url: String?
    //var uniquieID: String?
    //var img : UIImage?
    
    
}

/*
 
 
 override func viewWillAppear(_ animated: Bool)
 {
 super.viewWillAppear(true)
 
 // Add a background view to the table view
 let backgroundImage = UIImage(named: "ibeaco.png")
 let imageView = UIImageView(image: backgroundImage)
 self.tableView.backgroundView = imageView
 }

 
 
 
 
 case .browser:
 if let devicesUniqueID = action.devicesUniqueID?.contains("oHDN") {
 
 if let url = action.url {
 print("devicesUniqueID for oHDN URL: \(devicesUniqueID)")
 print("Browser Action for oHDN  URL: \(url)")
 
 self.fetchAdvertisement()
 
 }
 }
 
 else if let devicesUniqueID = action.devicesUniqueID?.contains("4tla") {
 
 if let url = action.url {
 print("devicesUniqueID for 4tla URL: \(devicesUniqueID)")
 print("Browser Action for 4tla URL: \(url)")
 
 self.fetchAdvertisement()
 
 }
 }
 
 
 
 else if let devicesUniqueID = action.devicesUniqueID?.contains("rTJz") {
 
 if let url = action.url {
 print("devicesUniqueID for rtjz URL: \(devicesUniqueID)")
 print("Browser Action for rtjz URL: \(url)")
 
 self.fetchAdvertisement()
 
 }
 }
 
 
 
 
 
 
 
 case .content:
 // if let contentAction = action.content, let url = contentAction.contentURL {
 //   print("Contant Action. Content URL: \(url)")
 
 
 if let devicesUniqueID = action.devicesUniqueID?.contains("oHDN")
 {
 if let contentAction = action.content{
 
 print("devicesUniqueID for ohdn Content: \(devicesUniqueID)")
 print("Contant Action. Content ohdn  URL: \(contentAction)")
 
 
 self.fetchAdvertisement()
 
 }
 }
 
 else if let devicesUniqueID = action.devicesUniqueID?.contains("4tla")
 {
 if let contentAction = action.content{
 
 print("devicesUniqueID for 4tla Content: \(devicesUniqueID)")
 print("Contant Action. Content 4tla URL: \(contentAction)")
 
 
 self.fetchAdvertisement()
 
 }
 }
 
 else if let devicesUniqueID = action.devicesUniqueID?.contains("rTJz")
 {
 if let contentAction = action.content{
 
 print("devicesUniqueID for rtjz Content: \(devicesUniqueID)")
 print("Contant Action. Content rtjz  URL: \(contentAction)")
 
 
 self.fetchAdvertisement()
 
 }
 }

 
 
 
import UIKit
import os.log

    class Beacons: NSObject, NSCoding {
 
    //MARK: Properties
 
 
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
 
    }
 
 
    //MARK: Initialization
 
    init?(name: String, photo: UIImage?) {
 
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
 
 
        // Initialize stored properties.
        self.name = name
        self.photo = photo
 
    }
        func encode(with aCoder: NSCoder) {
 
            aCoder.encode(name, forKey: PropertyKey.name)
            aCoder.encode(photo, forKey: PropertyKey.photo)
        }
        required convenience init?(coder aDecoder: NSCoder) {
 
            // The name is required. If we cannot decode a name string, the initializer should fail.
            guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
                os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
                return nil
            }
 
            // Because photo is an optional property of Meal, just use conditional cast.
            let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
 
 
 
            // Must call designated initializer.
            self.init(name: name, photo: photo)
 
 
        }
        //MARK: Archiving Paths
        static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        static let ArchiveURL = DocumentsDirectory.appendingPathComponent("beacons")

}
 */
