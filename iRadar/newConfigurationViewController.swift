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
    var myBeacons = ["4tla","rTJz","oHdN"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
           print("check1")
        devicesManager = KTKDevicesManager(delegate: self)
        devicesManager.startDevicesDiscovery(withInterval: 2.0)
    }
    
}

 extension newConfigurationViewController: KTKDevicesManagerDelegate {
    
    func devicesManager(_ manager: KTKDevicesManager, didDiscover devices: [KTKNearbyDevice]?) {
        print("check2")

        guard let nearbyDevices = devices else {
            return
        }
        
        if (devices?.filter({$0.uniqueID == "rTJz"}).first) != nil {
            print("check3")

            manager.stopDevicesDiscovery()
        for device in nearbyDevices {
            if let index = myBeacons.index(of: device.uniqueID!) {
                let config = KTKDeviceConfiguration()
                config.packets = [.iBeacon, .eddystoneURL]
                config.url = URL(string: "https://kontakt.io")
                config.minor = NSNumber(value: arc4random_uniform(16309))
                
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
                        print("Configuration for \(String(describing: configuration?.uniqueID!)) applied successfully")
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
        
        
        //
        else
            if (devices?.filter({$0.uniqueID == "4tla"}).first) != nil {
                print("check4")
                
                manager.stopDevicesDiscovery()
                for device in nearbyDevices {
                    if let index = myBeacons.index(of: device.uniqueID!) {
                        let config = KTKDeviceConfiguration()
                        config.packets = [.iBeacon, .eddystoneURL]
                        config.url = URL(string: "https://kontakt.io")
                        config.minor = NSNumber(value: arc4random_uniform(17108))
                        
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
                                print("Configuration for \(String(describing: configuration?.uniqueID!)) applied successfully")
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
        
        
        //
        
        else
        
                if (devices?.filter({$0.uniqueID == "oHdN"}).first) != nil {
                    print("check5")
                    
                    manager.stopDevicesDiscovery()
                    for device in nearbyDevices {
                        if let index = myBeacons.index(of: device.uniqueID!) {
                            let config = KTKDeviceConfiguration()
                            config.packets = [.iBeacon, .eddystoneURL]
                            config.url = URL(string: "https://kontakt.io")
                            config.minor = NSNumber(value: arc4random_uniform(64688))
                            
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
                                    print("Configuration for \(String(describing: configuration?.uniqueID!)) applied successfully")
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
        
        
        //
        
        //
        
        
}
}
