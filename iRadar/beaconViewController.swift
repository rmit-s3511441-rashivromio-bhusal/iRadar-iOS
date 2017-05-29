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
import UserNotifications


    class beaconViewController: UIViewController , GIDSignInUIDelegate {
        
               
        var beacons : [Beacons]? = []
        var hi : [BeaconTableViewController]? = []
        
        @IBOutlet weak var welcome: UILabel!
        @IBOutlet weak var profilePic: UIImageView!
        @IBOutlet weak var Signout: UIButton!
        
        var beaconManager: KTKBeaconManager!
        
        @IBOutlet weak var show2: UIButton!
       
        @IBOutlet weak var show1: UIButton!
        @IBOutlet weak var show: UIButton!
        @IBOutlet weak var major: UILabel!
        @IBOutlet var statusLabel: UILabel!
        
        
        
        func refreshInterface()
        {
            if let currentUser = GIDSignIn.sharedInstance().currentUser{
                
                
                let profilePicURL = currentUser.profile.imageURL(withDimension: 400)
              
                profilePic.image = UIImage(data: NSData(contentsOf : profilePicURL!)! as Data)
                profilePic.isHidden = false
                welcome.text = "Welcome to iRADAR" + "\t" + currentUser.profile.givenName
                welcome.isHidden = false
            }
        }
        
        override func viewWillAppear(_ animated: Bool)
        {
            super.viewWillAppear(true)
            
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "ibeaco.png")?.draw(in: self.view.bounds)
            
            let image: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            self.view.backgroundColor = UIColor(patternImage: image)
            
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
            let region = KTKBeaconRegion(proximityUUID: proximityUUID! as UUID, identifier: "rashiv.beacon")
            
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
            UIView.animate(withDuration: 0.5) { [unowned self] in
                switch distance {
                case .unknown:
                    self.view.backgroundColor = UIColor.gray
                    
                case .far:
                    self.view.backgroundColor = UIColor.white
                   
             /*       //checking//
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
                */
                    
                case .near:
                    
                    
                    
                    self.view.backgroundColor = UIColor.lightGray
                    //checking//
                    
                // BeaconTableViewController().fetchAdvertisement()
                    
//                    var img: String?
//                    let beaimgURL  = actionsFromJson["url"] as? String
                   
/*
                    
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
                    
*/

                    
                case .immediate:
                    
                    let hi = UIColor(red:65/255.0, green:105/255.0, blue:226/255.0, alpha:1.0)
                    
                    
                    self.view.backgroundColor = hi
                    
                   //self.view.backgroundColor = UIColor.red
                    //checking//
        /*
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
                    
*/
                   
                }
            }
        }
        
        //CHANGES
        
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        
     
        @IBAction func didTapshow(sender: UIButton){
           // beaconshow()
            print("show")
            self.performSegue(withIdentifier: "viewadvertisement", sender: self)
            
                        
           
            
        }
        
        @IBAction func didTapshow1(sender: UIButton){
            // beaconshow()
           print("show1")
            self.performSegue(withIdentifier: "advertisement2", sender: self)

                      
         
        }

        @IBAction func didTapshow2(sender: UIButton){
             //beaconshow()
            print("show2")
            
            
             self.performSegue(withIdentifier: "advertisement3", sender: self)
       
        }

    
        @IBAction func didTapSignOut(sender: AnyObject) {
            
          
            
            FIRAuth.auth()?.addStateDidChangeListener { auth, user in
                if let user = user {
                    print("User is signed in.")
                    print(user)
                } else {
                    print("User is signed out.")
                }

                let alertController = UIAlertController(
                    title: "Title",
                    message: "Message",
                    preferredStyle: UIAlertControllerStyle.alert
                )
                
                let cancelAction = UIAlertAction(
                    title: "Cancel",
                    style: UIAlertActionStyle.destructive) { (action) in
                
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
            
            statusLabel.text = "Did change location authorization status to: \(status.rawValue)"
            print("SOMETHING  HERE")
            if status == .authorizedAlways{
                 print("SOMETHING  ")
                // Region
                let proximityUUID = NSUUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")
                 print("S HERE")
                
               let region = KTKBeaconRegion(proximityUUID: proximityUUID! as UUID, identifier: "rashiv.beacon")
                 print("SOMETHING WRONG HERE again")
                
                // Region Properties
                region.notifyEntryStateOnDisplay = true
                
                beaconManager.startMonitoring(for: region)
                
                beaconManager.startRangingBeacons(in: region)
                
                beaconManager.requestState(for: region)
            }
        }
        
        func beaconManager(_ manager: KTKBeaconManager, monitoringDidFailFor region: KTKBeaconRegion?, withError error: Error?) {
            print("There is no any beacons in this area: \(String(describing: region))")
            print("Error: \(String(describing: error))")
            statusLabel.text = "The beacons are not available in this area: \(String(describing: region))"
            print("reach here")
            
//           show.isHidden = false
//            show1.isHidden = true
//            show2.isHidden = true

        }
        
        func beaconManager(_ manager: KTKBeaconManager, didStartMonitoringFor region: KTKBeaconRegion) {
         //    print("Did monitoring region \(region)")
          statusLabel.text = "Started to  monitoring  for region: \(region)"
            
        }
        
    
        func beaconManager(_ manager: KTKBeaconManager, didEnter region: KTKBeaconRegion) {
            print("Did enter region: \(region)")
            statusLabel.text = "Enter region of the beacons: \(region)"
        }
        
        func beaconManager(_ manager: KTKBeaconManager, didExitRegion region: KTKBeaconRegion) {
            print(" Exit region \(region)")
            statusLabel.text = " Exit region \(region)"
        }
      
        func beaconManager(_ manager: KTKBeaconManager, didRangeBeacons beacons: [CLBeacon], in region: KTKBeaconRegion) {
            print("Did ranged \"\(beacons.count)\" beacons inside region: \(region)")
            statusLabel.text = " Ranging now \"\(beacons.count)\""
           // statusLabel.text = "Did ranged \"\(beacons.count)\" beacons inside region: \(region)"
            if let closestBeacon = beacons.sorted(by: { $0.0.accuracy < $0.1.accuracy }).first , closestBeacon.accuracy > 0 {
                
                print("Closest Beacon is M: \(closestBeacon.major), m: \(closestBeacon.minor) ~ \(closestBeacon.accuracy) meters away.")
                major.text = " Closest Beacon from you is \(closestBeacon.major) "
               // statusLabel.text = "\(String(describing: statusLabel.text)) Closest Beacon is M: \(closestBeacon.major), m: \(closestBeacon.minor) ~ \(closestBeacon.accuracy) meters away."
                //CHANGES//
                
           
                
              
                
                    if (closestBeacon.major == 8076)
                    {
                        
                        didTapshow(sender: UIButton())
                        show.isHidden = false
                        show1.isHidden = true
                        show2.isHidden = true
                        
                    

                        
                        
//                        if beacons.count > 0 {
//                            let beacon = beacons[0]
//                            update(distance: beacon.proximity)
//                        } else {
//                            update(distance: .unknown)
//                        }
                        
                        
                    }
                
                
                     if (closestBeacon.major == 52060)
                    {
                      

//                        if beacons.count > 0 {
//                            let beacon = beacons[0]
//                            update(distance: beacon.proximity)
//                        } else {
//                            update(distance: .unknown)
//                        }

                        didTapshow1(sender: UIButton())
                        show1.isHidden = false
                        show.isHidden = true
                        show2.isHidden = true
                    
                        
                        //beaconManager(<#T##manager: KTKBeaconManager##KTKBeaconManager#>, didRangeBeacons: <#T##[CLBeacon]#>, in: <#T##KTKBeaconRegion#>)
                        
                        
                    }
                
                
                     if (closestBeacon.major == 57656)
                    {
                       
//                        if beacons.count > 0 {
//                            let beacon = beacons[0]
//                            update(distance: beacon.proximity)
//                        } else {
//                            update(distance: .unknown)
//                        }

                        
                        didTapshow2(sender: UIButton())
                        show2.isHidden = false
                        show1.isHidden = true
                        show.isHidden = true
                     
                        
                    }
                
                
                
          
                if (closestBeacon.major != 8076 || closestBeacon.major != 52060 || closestBeacon.major != 57656)
                {
                    didTapshow(sender: UIButton())
                    
                    show1.isHidden = true
                    show2.isHidden = true
                    
                    
                    
                }
 
//
                
                
                if beacons.count > 0 {
                    let beacon = beacons[0]
                    update(distance: beacon.proximity)
                } else {
                    update(distance: .unknown)
                }
                
                                    }
        }
        

}


