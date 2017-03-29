//
//  NearbyDeviceClass.swift
//  iRadar
//
//  Created by Rashiv Romio Bhusal on 28/3/17.
//  Copyright © 2017 Rashiv Romio Bhusal. All rights reserved.
//

import Foundation
import UIKit
import KontaktSDK

class NearbyDeviceClass : UIViewController {
    
    var devicesManager: KTKDevicesManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        devicesManager = KTKDevicesManager(delegate: self)
//        if devicesManager.centralState = CBCentralManagerOptionShowPowerAlertKey {
//            devicesManager.startDevicesDiscovery(withInterval: 2.0)
       // }
        
    }
}



extension NearbyDeviceClass: KTKDevicesManagerDelegate {
    func devicesManager(_ manager: KTKDevicesManager, didDiscover devices: [KTKNearbyDevice]?) {
        
        if let device = devices?.filter({$0.uniqueID == "abcd"}).first {
            
            
            let connection = KTKDeviceConnection(nearbyDevice: device)
            connection.readConfiguration() { configuration, error in
                if error == nil, let config = configuration {
                    print("Advertising interval for beacon \(config.uniqueID) is \(config.advertisingInterval!)ms")
                }
            }
            
            let newConfiguration = KTKDeviceConfiguration(uniqueID: device.uniqueID!)
            newConfiguration.major = 123
            newConfiguration.transmissionPower = .power5
        }
        
        
    }
}

