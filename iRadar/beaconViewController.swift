//
//  ViewController.swift
//  iRadar
//
//  Created by Rashiv Romio Bhusal on 24/3/17.
//  Copyright © 2017 Rashiv Romio Bhusal. All rights reserved.
//

 
    import KontaktSDK
   import GoogleSignIn
    import Firebase


    class beaconViewController: UIViewController , GIDSignInUIDelegate {
        
        var beacons : [Beacons]? = []
        var hi : [BeaconTableViewController]? = []
        
        @IBOutlet weak var beaimg: UIImageView!
        @IBOutlet weak var profilePic: UIImageView!
        @IBOutlet weak var Signout: UIButton!
        
        @IBOutlet weak var googleimage: UIImageView!
        var beaconManager: KTKBeaconManager!
        
       
        @IBOutlet weak var show: UIButton!
        @IBOutlet weak var major: UILabel!
        @IBOutlet var statusLabel: UILabel!
        
        
        
        func refreshInterface()
        {
            // beaconManager.stopMonitoringForAllRegions()
            print("hi")
            if let currentUser = GIDSignIn.sharedInstance().currentUser{
                
                
                let profilePicURL = currentUser.profile.imageURL(withDimension: 400)
                profilePic.image = UIImage(data: NSData(contentsOf : profilePicURL!)! as Data)
                profilePic.isHidden = false
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            GIDSignIn.sharedInstance().uiDelegate = self
            refreshInterface()
             print("faaaaaaaaa")
            // Initiate Beacon Manager
            beaconManager = KTKBeaconManager(delegate: self)
            beaconManager.requestLocationAlwaysAuthorization()
             print("aaaaarerfsdfdf")
            
            // Region
            let proximityUUID = NSUUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")
            
            
//            let major: CLBeaconMajorValue = CLBeaconMajorValue(arc4random_uniform(5000))
//            let minor: CLBeaconMinorValue = CLBeaconMajorValue(arc4random_uniform(5000))
//            
           // let beaconPeripheralData: NSDictionary = region.peripheralData(withMeasuredPower: nil) as NSDictionary

            
            let region = KTKBeaconRegion(proximityUUID: proximityUUID! as UUID, identifier: "rashiv.beacon")
            
            //,major: 8076, minor: 17108
            
            //major: 52060, minor: 16309
          
           // let region = KTKBeaconRegion(proximityUUID: proximityUUID! as UUID,major: major, minor: minor, identifier: "rashiv.beacon")
           
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
                    print("Monitoring turned on for region: \(region)")
                //CBPeripheralDelegate?.monitoringOperationDidStartSuccessfully()
                }                // We will use this later
            }

            
            // Do any additional setup after loading the view, typically from a nib.
        }
       
        
        
        ///CHANGES//
        func update(distance: CLProximity) {
            UIView.animate(withDuration: 0.1) { [unowned self] in
                switch distance {
                case .unknown:
                    self.view.backgroundColor = UIColor.gray
                    
                case .far:
                    self.view.backgroundColor = UIColor.white
                   
                    //checking//
                    ////CHANGES
                    let title = "FAR"
                    let message = "This is far"
                    let cancelButtonTitle = "Cancel"
                    let okButtonTitle = "OK"
                    
                    let alertController = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
                    let cancelAction = UIAlertAction.init(title: cancelButtonTitle, style: UIAlertActionStyle.cancel, handler: nil)
                    let okAction = UIAlertAction(
                    title: "OK", style: UIAlertActionStyle.default){ (action) in
                        self.performSegue(withIdentifier: "viewadvertisement", sender: self)
                    }
                    alertController.addAction(cancelAction);
                    alertController.addAction(okAction);
                    
                    //CHECKING
                    if ( okButtonTitle == "ok" )
                    {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                    }
                    
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    
                case .near:
                    self.view.backgroundColor = UIColor.green
                    //checking//
                // BeaconTableViewController().fetchAdvertisement()
                    
//                    var img: String?
//                    let beaimgURL  = actionsFromJson["url"] as? String
                   

                    
                    let title = "NEAR"
                    let message = "This is NEAR"
                    let cancelButtonTitle = "Cancel"
                    let okButtonTitle = "Ok"
                    
                    let alertController = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
                    let cancelAction = UIAlertAction.init(title: cancelButtonTitle, style: UIAlertActionStyle.cancel, handler: nil)
                    let okAction = UIAlertAction(
                    title: "OK", style: UIAlertActionStyle.default){ (action) in
                        self.performSegue(withIdentifier: "viewadvertisement", sender: self)
                    }
                    alertController.addAction(cancelAction);
                    alertController.addAction(okAction);
                    //CHECKING
                    if ( okButtonTitle == "ok" )
                    {
                        print("CHECKING THE  LOADED")
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "beacontableviewcell"), object: nil)
                        
                        print("CHECKING THE IMAGES LOADED ha")
                        
                        
                        
                    }
                    
                    
                    self.present(alertController, animated: true, completion: nil)
                    


                    
                case .immediate:
                    
                    
                    self.view.backgroundColor = UIColor.red
                    //checking//
                                        let title = "IMMEDIATE"
                    let message = "This is right next to you"
                    let cancelButtonTitle = "Cancel"
                    let okButtonTitle = "Ok"
                    
                    let alertController = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
                    let cancelAction = UIAlertAction.init(title: cancelButtonTitle, style: UIAlertActionStyle.cancel, handler: nil)
                    
                    
                     //let okAction = UIAlertAction.init(title: okButtonTitle, style: UIAlertActionStyle.default)
                    
                    let okAction = UIAlertAction(
                        title: "OK", style: UIAlertActionStyle.default){ (action) in
                                self.performSegue(withIdentifier: "viewadvertisement", sender: self)
                    }
                    alertController.addAction(cancelAction);
                    alertController.addAction(okAction);
                    
                    //CHECKING
                    if ( okButtonTitle == "ok" )
                    {
                        print("CHECKING THE  LOADED")
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "beacontableviewcell"), object: nil)
                        
                        print("CHECKING THE IMAGES LOADED ha")
                        
                        
                        
                    }
                    
                    
                    self.present(alertController, animated: true, completion: nil)
                    

                   
                }
            }
        }
        
        //CHANGES
        
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
       
        
       
        
        
        
        //
        
        //
        @IBAction func didTapSignOut(sender: AnyObject) {
            
          
            
            FIRAuth.auth()?.addStateDidChangeListener { auth, user in
                if case let user = user {
                    print("User is signed in.")
                } else {
                    print("User is signed out.")
                }

            
                //
                let alertController = UIAlertController(
                    title: "Title",
                    message: "Message",
                    preferredStyle: UIAlertControllerStyle.alert
                )
                
                let cancelAction = UIAlertAction(
                    title: "Cancel",
                    style: UIAlertActionStyle.destructive) { (action) in
                        // ...
                }
                
                let confirmAction = UIAlertAction(
                title: "OK", style: UIAlertActionStyle.default) { (action) in
                    self.performSegue(withIdentifier: "logout", sender: self)
                
                    print("sign out button tapped")
                    let firebaseAuth = FIRAuth.auth()
                    do {
                        try firebaseAuth!.signOut()
                        
                        //        GIDGoogleUser.sharedInstance.signedIn = false
                        // dismissViewControllerAnimated(true, completion: nil)
                    } catch let signOutError as NSError {
                        print ("Error signing out: \(signOutError)")
                    } catch {
                        print("Unknown error.")
                    }
                    
                    
                    GIDSignIn.sharedInstance().signOut()
                    let proximityUUID = NSUUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")

                    let region = KTKBeaconRegion(proximityUUID: proximityUUID! as UUID, identifier: "rashiv.beacon")
                    self.beaconManager.stopMonitoring(for: region)
                
                }
                alertController.addAction(confirmAction)
                alertController.addAction(cancelAction)
                
                //change here
                 self.beaconManager.stopMonitoringForAllRegions()
                //change here
                
                self.present(alertController, animated: true, completion: nil)
                
                //
             
           
        }
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
                
                
                
//                let major: CLBeaconMajorValue = CLBeaconMajorValue(arc4random_uniform(5000))
//                let minor: CLBeaconMinorValue = CLBeaconMajorValue(arc4random_uniform(5000))
//                
                // let beaconPeripheralData: NSDictionary = region.peripheralData(withMeasuredPower: nil) as NSDictionary
                
                
                
               // let region = KTKBeaconRegion(proximityUUID: proximityUUID! as UUID,major: major, minor: minor, identifier: "rashiv.beacon")
                

                  // let region = KTKBeaconRegion(proximityUUID: proximityUUID! as UUID, major: 52060, minor: 16309, identifier: "rashiv.beacon")
                
               let region = KTKBeaconRegion(proximityUUID: proximityUUID! as UUID, identifier: "rashiv.beacon")
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
            print("Monitoring did fail for region: \(String(describing: region))")
            print("Error: \(String(describing: error))")
            statusLabel.text = "Monitoring did fail for region: \(String(describing: region))"
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
            statusLabel.text = "Did ranged \"\(beacons.count)\""
           // statusLabel.text = "Did ranged \"\(beacons.count)\" beacons inside region: \(region)"
            if let closestBeacon = beacons.sorted(by: { $0.0.accuracy < $0.1.accuracy }).first , closestBeacon.accuracy > 0 {
                
                //print("Closest Beacon is M: \(closestBeacon.major), m: \(closestBeacon.minor) ~ \(closestBeacon.accuracy) meters away.")
                major.text = " closestBeacon.major is \(closestBeacon.major) "
               // statusLabel.text = "\(String(describing: statusLabel.text)) Closest Beacon is M: \(closestBeacon.major), m: \(closestBeacon.minor) ~ \(closestBeacon.accuracy) meters away."
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
            
            //beaconManager(<#T##manager: KTKBeaconManager##KTKBeaconManager#>, didRangeBeacons: <#T##[CLBeacon]#>, in: <#T##KTKBeaconRegion#>)
            if let currentUser = GIDSignIn.sharedInstance().currentUser{
         //   GIDSignIn.sharedInstance().signIn()
           let name = currentUser.profile.name!
           let email = currentUser.profile.email!
            
                
               let major: CLBeaconMajorValue = CLBeaconMajorValue(arc4random_uniform(5000))
                 let minor: CLBeaconMinorValue = CLBeaconMajorValue(arc4random_uniform(5000))
                
                
//            
            //    let proximityUUID = NSUUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")
                
                 //let region = KTKBeaconRegion(proximityUUID: proximityUUID! as UUID,major: major,minor: minor, identifier: "rashiv.beacon")
               // let region = KTKBeaconRegion(proximityUUID: proximityUUID! as UUID,major: major, minor: minor, identifier: "rashiv.beacon")
                

     
                let parameter = ["beacond_id_major": major ,"beacond_id_minor": minor , "name" : name, "special": "f7826da6-4fa2-4e98-8024-bc5b71e0893e" ,"customer": email] as [String: Any]
           // let parameter = ["beacon": "4tla", "special":"f7826da6-4fa2-4e98-8024-bc5b71e0893e", "customer": "rashiv"] as [String: Any]
            
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

}


///
/*
 extension CLBeacon
 {
 /// Returns a specially-formatted description of the beacon's characteristics.
 func fullDetails() -> String {
 let proximityText: String
 
 switch proximity {
 case .near:
 proximityText = "Near"
 case .immediate:
 proximityText = "Immediate"
 case .far:
 proximityText = "Far"
 case .unknown:
 proximityText = "Unknown"
 }
 
 return "\(major), \(minor) •  \(proximityText) • \(accuracy) • \(rssi)"
 }
 }
 */
