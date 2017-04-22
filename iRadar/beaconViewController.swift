//
//  ViewController.swift
//  iRadar
//
//  Created by Rashiv Romio Bhusal on 24/3/17.
//  Copyright © 2017 Rashiv Romio Bhusal. All rights reserved.
//

    import UIKit
    import KontaktSDK
    import GoogleSignIn
    
    class beaconViewController: UIViewController {
        
        var beaconManager: KTKBeaconManager!
        
       
        @IBOutlet weak var show: UIButton!
        @IBOutlet weak var major: UILabel!
        @IBOutlet var statusLabel: UILabel!
        override func viewDidLoad() {
            super.viewDidLoad()
            
             print("faaaaaaaaa")
            // Initiate Beacon Manager
            beaconManager = KTKBeaconManager(delegate: self)
            beaconManager.requestLocationAlwaysAuthorization()
             print("aaaaarerfsdfdf")
            
            // Region
            let proximityUUID = NSUUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")
            
            let major: CLBeaconMajorValue = CLBeaconMajorValue(arc4random_uniform(5000))
            let minor: CLBeaconMinorValue = CLBeaconMajorValue(arc4random_uniform(5000))
            
           // let beaconPeripheralData: NSDictionary = region.peripheralData(withMeasuredPower: nil) as NSDictionary

            
          
            let region = KTKBeaconRegion(proximityUUID: proximityUUID! as UUID,major: major, minor: minor, identifier: "rashiv.beacon")
           
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
        ///CHANGES//
        func update(distance: CLProximity) {
            UIView.animate(withDuration: 0.8) { [unowned self] in
                switch distance {
                case .unknown:
                    self.view.backgroundColor = UIColor.gray
                    
                case .far:
                    self.view.backgroundColor = UIColor.blue
                    
                    
                case .near:
                    self.view.backgroundColor = UIColor.orange
                    
                case .immediate:
                    self.view.backgroundColor = UIColor.red
                   
                }
            }
        }
        
        //CHANGES
        
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
       
        
    }


    extension beaconViewController: KTKBeaconManagerDelegate {
        
        func beaconManager(_ manager: KTKBeaconManager, didDetermineState state: CLRegionState, for region: KTKBeaconRegion) {
            print("Did determine state \"\(state.rawValue)\" for region: \(region)")
            statusLabel.text = "Did determine state \"\(state.rawValue)\" for region: \(region)"
        }
        
        func beaconManager(_ manager: KTKBeaconManager, didChangeLocationAuthorizationStatus status: CLAuthorizationStatus) {
            print("Did change location authorization status to: \(status.rawValue)")
            
            
            //changes ------------------------------============332223#####################################################//
             //changes ------------------------------============332223#####################################################//
             //changes ------------------------------============332223#####################################################//
            fetchAdvertisementhere()
            
             //changes ------------------------------============332223#####################################################//
             //changes ------------------------------============332223#####################################################//
             //changes ------------------------------============332223#####################################################//
             //changes ------------------------------============332223#####################################################//
            
            print("SOMETHING WRONG HERE")
            
            
            
           statusLabel.text = "Did change location authorization status to: \(status.rawValue)"
             print("SOMETHING  HERE")
            if status == .authorizedAlways{
                 print("SOMETHING  ")
                // Region
                let proximityUUID = NSUUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")
                 print("S HERE")
                
              //  let region = KTKBeaconRegion(proximityUUID: NSUUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e"), major: <#T##CLBeaconMajorValue#>, minor: <#T##CLBeaconMinorValue#>, identifier: <#T##String#>)
                
                
                
                let major: CLBeaconMajorValue = CLBeaconMajorValue(arc4random_uniform(5000))
                let minor: CLBeaconMinorValue = CLBeaconMajorValue(arc4random_uniform(5000))
                
                // let beaconPeripheralData: NSDictionary = region.peripheralData(withMeasuredPower: nil) as NSDictionary
                
                
                
                let region = KTKBeaconRegion(proximityUUID: proximityUUID! as UUID,major: major, minor: minor, identifier: "rashiv.beacon")
                

                
                
                //let region = KTKBeaconRegion(proximityUUID: proximityUUID! as UUID,major: 8076, minor: 17108, identifier: "rashiv.beacon")
                 print("SOMETHING WRONG HERE again")
                
                // Region Properties
                region.notifyEntryStateOnDisplay = true
                 print("Siloo HERE")
                beaconManager.startMonitoring(for: region)
                 print("SnjvhoilopotreevvE")
                beaconManager.startRangingBeacons(in: region)
                 print("SOewoiyt pop ")
                beaconManager.requestState(for: region)
            }
        }
        
        func beaconManager(_ manager: KTKBeaconManager, monitoringDidFailFor region: KTKBeaconRegion?, withError error: Error?) {
            print("Monitoring did fail for region: \(region)")
            print("Error: \(error)")
            statusLabel.text = "Monitoring did fail for region: \(region)"
            print("reach here")
        }
        
        func beaconManager(_ manager: KTKBeaconManager, didStartMonitoringFor region: KTKBeaconRegion) {
             print("Did monitoring region \(region)")
          statusLabel.text = "Did start monitoring for region: \(region)"
            
            fetchAdvertisementhere()
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
                major.text = " closestBeacon.major is \(closestBeacon.major) "
                statusLabel.text = "\(statusLabel.text) Closest Beacon is M: \(closestBeacon.major), m: \(closestBeacon.minor) ~ \(closestBeacon.accuracy) meters away."
                //CHANGES//
                if beacons.count > 0 {
                    let beacon = beacons[0]
                    update(distance: beacon.proximity)
                } else {
                    update(distance: .unknown)
                }
                //CHANGES//
                
                
            }
        }
        
       
        
        
        
        private func fetchAdvertisementhere(){
            print("EHU 1")
            
         
            
            let parameter = ["beacon": "4tla", "special":"f7826da6-4fa2-4e98-8024-bc5b71e0893e", "customer": "rashiv"] as [String: Any]
            
            let myUrl = URL(string: "https://iradar-dev.appspot.com/api/impression");
            var request = URLRequest(url:myUrl!);
            
            let postString = "beacon=4tla&customer=rashiv"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
            print(postString)
            
            
            request.httpMethod = "POST";
            request.addValue("tmwNSX5uC4JjVnZsUZFnKcJW", forHTTPHeaderField: "Api-Key")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            do {

                request.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
                
                
            }
            catch let error  {
                print(error.localizedDescription)
            }
            
            print("Request printing")
            print (request)
            print("This is the request")
            print(JSONSerialization.self)
            
            let task = URLSession.shared.dataTask(with: request)
            {
                (data,response,error) in
                if let httpResponse = response as? HTTPURLResponse {
                    print("The  statusCode of this url is : \(httpResponse.statusCode)")
                    print("hello buddy")
                }
                
                
                if error != nil {
                    print(error as Any)
                    return
                }
                print("Now in the JSON")
                
                do{
                    
                    let parseData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print("reachin")
                    let disc = parseData as! NSDictionary
                    print(disc)
                    print("no")
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                    print("yes")
                    
                    if let actionsFromJson = json["actions"] as? [[String : AnyObject]]
                    {
                        print("do u know what is here")
                        for actionsFromJson in actionsFromJson {
                            
                            
                            if let beaco = actionsFromJson["beacon"] as? String ,let cust = actionsFromJson["customer"] as? String  {
                                
                                print(beaco)
                                print(cust)
                                print("where is the output")
                                
                            }
                            
                            //    else if let title = actionsFromJson["actionType"] as? String ,let desc = actionsFromJson["proximity"] as? String , let img = actionsFromJson["content"] as? String {
                            
                            
                            // }
                            
                            
                            
                        }
                        
                    }
                    //                
                    //                DispatchQueue.main.async {
                    //                 //   self.tableView.reloadData()
                    //                    
                    //                }
                    //                
                    
                }
                catch let error{
                    print(error)
                }
                
            }
            task.resume()
            
            
        }
        
        

        
        
        
        
}
