//
//  ViewController.swift
//  iRadar
//
//  Created by Rashiv Romio Bhusal on 24/3/17.
//  Copyright © 2017 Rashiv Romio Bhusal. All rights reserved.
//

    import UIKit
    import KontaktSDK
    
    class beaconViewController: UIViewController {
        
        var beaconManager: KTKBeaconManager!
        
        @IBOutlet var statusLabel: UILabel!
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            // Initiate Beacon Manager
            beaconManager = KTKBeaconManager(delegate: self)
            beaconManager.requestLocationAlwaysAuthorization()
           /*
            
            let uuid = UUID(uuidString:"f7826da6-4fa2-4e98-8024-bc5b71e0893e")!
            
            //marks : changed the major value here
            let major:CLBeaconMajorValue = 52060
            
            // marks: change the minor value here
            
            let minor:CLBeaconMinorValue = 16309
            
            // marks: change the beacon name as on the identifier presented
            
            let identifier = "rashiv.beacon"
            
            */
            
            
            
            
            // Region
            let proximityUUID = NSUUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")
            
           // let region = KTKBeaconRegion(proximityUUID: proximityUUID! as UUID, identifier: "rashiv.beacon")
            let region = KTKBeaconRegion(proximityUUID: proximityUUID! as UUID,major: 52060, minor: 16309, identifier: "rashiv.beacon")
            
            // Region Properties
            region.notifyEntryStateOnDisplay = true
            
            beaconManager.stopMonitoringForAllRegions()
            
            // Start Ranging
            beaconManager.startMonitoring(for: region)
            beaconManager.startRangingBeacons(in: region)
            beaconManager.requestState(for: region)
            
            
            
            switch KTKBeaconManager.locationAuthorizationStatus() {
            case .notDetermined:
                beaconManager.requestLocationAlwaysAuthorization()
            case .denied, .restricted:
                beaconManager.requestLocationAlwaysAuthorization()
            // No access to Location Services
            case .authorizedWhenInUse:
                beaconManager.requestLocationAlwaysAuthorization()
                // For most iBeacon-based app this type of
            // permission is not adequate
            case .authorizedAlways:
                if KTKBeaconManager.isMonitoringAvailable() {
                    beaconManager.startMonitoring(for: region)
                }                // We will use this later
            }

            
            // Do any additional setup after loading the view, typically from a nib.
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
    }


    extension beaconViewController: KTKBeaconManagerDelegate {
        
        func beaconManager(_ manager: KTKBeaconManager, didDetermineState state: CLRegionState, for region: KTKBeaconRegion) {
            print("Did determine state \"\(state.rawValue)\" for region: \(region)")
           // statusLabel.text = "Did determine state \"\(state.rawValue)\" for region: \(region)"
        }
        
        func beaconManager(_ manager: KTKBeaconManager, didChangeLocationAuthorizationStatus status: CLAuthorizationStatus) {
            print("Did change location authorization status to: \(status.rawValue)")
            
            
            
            print("SOMETHING WRONG HERE")
            
            
            
           statusLabel.text = "Did change location authorization status to: \(status.rawValue)"
            if status == .authorizedAlways{
                
                // Region
                let proximityUUID = NSUUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")
                
              //  let region = KTKBeaconRegion(proximityUUID: NSUUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e"), major: <#T##CLBeaconMajorValue#>, minor: <#T##CLBeaconMinorValue#>, identifier: <#T##String#>)
                let region = KTKBeaconRegion(proximityUUID: proximityUUID! as UUID,major: 52060, minor: 16309, identifier: "rashiv.beacon")
                
                // Region Properties
                region.notifyEntryStateOnDisplay = true
                
                beaconManager.startMonitoring(for: region)
                beaconManager.startRangingBeacons(in: region)
                beaconManager.requestState(for: region)
            }
        }
        
        func beaconManager(_ manager: KTKBeaconManager, monitoringDidFailFor region: KTKBeaconRegion?, withError error: Error?) {
            print("Monitoring did fail for region: \(region)")
            print("Error: \(error)")
            statusLabel.text = "Monitoring did fail for region: \(region)"
        }
        
        func beaconManager(_ manager: KTKBeaconManager, didStartMonitoringFor region: KTKBeaconRegion) {
            print("Did start monitoring for region: \(region)")
           statusLabel.text = "Did start monitoring for region: \(region)"
        }
        
        func beaconManager(_ manager: KTKBeaconManager, didEnter region: KTKBeaconRegion) {
            print("Did enter region: \(region)")
            statusLabel.text = "Did enter region: \(region)"
        }
        
        func beaconManager(_ manager: KTKBeaconManager, didExitRegion region: KTKBeaconRegion) {
            print("Did exit region \(region)")
            statusLabel.text = "Did exit region \(region)"
        }
        
        func beaconManager(_ manager: KTKBeaconManager, didRangeBeacons beacons: [CLBeacon], in region: KTKBeaconRegion) {
            print("Did ranged \"\(beacons.count)\" beacons inside region: \(region)")
            statusLabel.text = "Did ranged \"\(beacons.count)\" beacons inside region: \(region)"
            if let closestBeacon = beacons.sorted(by: { $0.0.accuracy < $0.1.accuracy }).first , closestBeacon.accuracy > 0 {
                print("Closest Beacon is M: \(closestBeacon.major), m: \(closestBeacon.minor) ~ \(closestBeacon.accuracy) meters away.")
                statusLabel.text = "\(statusLabel.text) Closest Beacon is M: \(closestBeacon.major), m: \(closestBeacon.minor) ~ \(closestBeacon.accuracy) meters away."
            }
        }
}
