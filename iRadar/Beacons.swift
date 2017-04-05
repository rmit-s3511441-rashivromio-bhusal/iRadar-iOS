//
//  Beacons.swift
//  iRadar
//
//  Created by Rashiv Romio Bhusal on 3/4/17.
//  Copyright © 2017 Rashiv Romio Bhusal. All rights reserved.
//





import UIKit

class Beacons: NSObject {
    
    
  
    var title: String?
    var desc: String?
    var img: String?
    
    
}

/*
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
