//
//  newConfigurationViewController.swift
//  iRadar
//
//  Created by Rashiv Romio Bhusal on 28/3/17.
//  Copyright © 2017 Rashiv Romio Bhusal. All rights reserved.
//

import Foundation
import UIKit
import KontaktSDK

class newConfigurationViewController: UIViewController {
    
    var devicesManager: KTKDevicesManager!
    var myBeacons = ["abcd", "efgh", "ijkl"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        devicesManager = KTKDevicesManager(delegate: self)
        devicesManager.startDevicesDiscovery(withInterval: 2.0)
    }
    
}

 extension newConfigurationViewController: KTKDevicesManagerDelegate {
    
    func devicesManager(_ manager: KTKDevicesManager, didDiscover devices: [KTKNearbyDevice]?) {
        
        guard let nearbyDevices = devices else {
            return
        }
        
        if let device = devices?.filter({$0.uniqueID == "abcd"}).first {
            manager.stopDevicesDiscovery()
        for device in nearbyDevices {
            if let index = myBeacons.index(of: device.uniqueID!) {
                let config = KTKDeviceConfiguration()
                config.packets = [.iBeacon, .eddystoneURL]
                config.url = URL(string: "https://kontakt.io")
                config.minor = NSNumber(value: arc4random_uniform(65536))
                
                let connection = KTKDeviceConnection(nearbyDevice: device)
                
                
                KTKFirmware.getFirmwaresForUniqueIDs(["abcd"]) { firmware, error in
                    if let fw = firmware?.first {
                      connection.update(with: fw, progress: { print("Firmware upgrade progress: \($0)%")}) { synchronized, error in
                            if let _ = error {
                                print("Firmware upgrade failed")
                            } else if !synchronized {
                                // Kontakt.io Cloud has not been notified about a firmware upgrade.
                                // Save this information and try later.
                            } else {
                                print("Successful firmware upgrade")
                            }
                        }
                    }
                }
                
                connection.write(config, completion: { (synchronized, configuration, error) in
                    if error == nil {
                        print("Configuration for \(configuration?.uniqueID!) applied successfully")
                    }
                })
                
                myBeacons.remove(at: index)
            }
            
            if myBeacons.isEmpty {
                manager.stopDevicesDiscovery()
                print("Scanning has stopped")
                break
            } else {
                print("Still scanning...")
            }
        }
    }
}
}
