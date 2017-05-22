//
//  Beacon2TableViewController.swift
//  iRadar
//
//  Created by Rashiv Romio Bhusal on 19/5/17.
//  Copyright © 2017 Rashiv Romio Bhusal. All rights reserved.
//

import UIKit
import KontaktSDK
import GoogleSignIn
import Firebase

class Beacon2TableViewController: UITableViewController {

    
    
   
    
    @IBOutlet weak var back: UIBarButtonItem!
    @IBOutlet weak var SignOut: UIBarButtonItem!
    var beacons : [Beacons] = []
    
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
        // Add a background view to the table view
        let backgroundImage = UIImage(named: "ibeaco.png")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // refreshControl -> pull to refresh handler
        let refreshControl = UIRefreshControl()
        self.refreshControl = refreshControl
        
        apicall()
        
    }
    
    
    
    func loadList(notification: NSNotification){
        //load data here
        self.tableView.reloadData()
    }
    
    
    func apicall(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        let apiClient = KTKCloudClient.sharedInstance()
        
        let parameters = ["uniqueId": "rTJz"]
        
        
        apiClient.getObjects(KTKAction.self, parameters: parameters) { (response, error) in
            if let cloudError = KTKCloudErrorFromError(error) {
                print(cloudError.debugDescription)
            } else if let actions = response?.objects as? [KTKAction] {
                for action in actions {
                    switch action.type {
                    case .browser:
                        if let url = action.url {
                            
                                
                             if let devicesUniqueID = action.devicesUniqueID?.contains("rTJz"){
                                
                                
                                print("Browser Action for URL: \(url)")
                                print("B Action for URL: \(devicesUniqueID)")
                                print(action.actionID)
                                
                                
                                self.fetchrTJz()
                            
                         
                            }
                        }
                        
                    case .content:
                        
                        if let contentAction = action.content{
                            
                             if let devicesUniqueID = action.devicesUniqueID?.contains("rTJz"){
                                
                                print("Contant Action. Content URL: \(contentAction)")
                                print(" Action. Content : \(devicesUniqueID)")
                                
                                
                                
                                
                                self.fetchrTJz()
                            }
                            
                        }
                        
                    case .invalid:
                        print("Invalid action")
                    }
                    
                    
                    
                    
                    
                    
                }
            }
        }
    }
    
   
    
    
    //==============================================================================
    //MARK : -  Fetch data for rtjz
    
    
    public func fetchrTJz(){
        print("EHU 1")
        
        let myUrl = URL(string: "https://api.kontakt.io/action?uniqueId=rTJz");
        var request = URLRequest(url:myUrl!);
        request.httpMethod = "GET";
        request.addValue("vnrXRFJARjeLgIVLBeqmHkXMxXEVsNRm", forHTTPHeaderField: "Api-Key")
        request.addValue("application/vnd.com.kontakt+json;version=10", forHTTPHeaderField: "Accept")
        print("EHU 2 ")
        print (request)
        //   print(response)
        
        
        let task = URLSession.shared.dataTask(with: request)
        {
            
            (data,response,error) in
            
            
            guard let data = data , error == nil else {
                self.tableView.reloadData()
                
                return
            }
            
            
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
                print("hi")
                // }
                //change here
                
                
                if error != nil {
                    print(error as Any)
                    return
                }
                
                
                self.beacons = [Beacons]()
                
                do{
                    
                    //  let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                    
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as![String : AnyObject]
                    
                    
                    if let actionsFromJson = json["actions"] as? [[String : AnyObject]]
                    {
                        
                        
                        
                        for actionsFromJson in actionsFromJson {
                            
                            let beacon = Beacons()
                            
                            //                       for (key, value) in actionsFromJson {
                            //                      print("\(key) -> \(value)")
                            
                            // for value in actionsFromJson.values {
                            //   print("\(value)")
                            
                            // if let deviceUniqueIds = actionsFromJson["devicesUniqueID"]?.contains("4tla") {
                            
                            // let uniqueId = actionsFromJson["deviceUniqueIds"]?["4tla"] as? String
                            
                            if let title = actionsFromJson["actionType"] as? String ,let desc = actionsFromJson["proximity"] as? String , let img = actionsFromJson["url"] as? String {
                                
                                // print(deviceUniqueIds)
                                //  print(uniqueId)
                                //  print(title)
                                // print(desc)
                                // print(title)
                                
                                beacon.title = title
                                beacon.desc = desc
                                beacon.img = img
                                
                            }
                                
                                
                                
                            else if let title = actionsFromJson["actionType"] as? String ,let desc = actionsFromJson["proximity"] as? String , let img = actionsFromJson["content"] as? String  {
                                // print(uniqueId)
                                
                                //  print(title)
                                // print(desc)
                                // print(title)
                                
                                beacon.title = title
                                beacon.desc = desc
                                beacon.img = img
                            }
                            
                            
                            //  }
                            self.beacons.append(beacon)
                        }
                        
                    }
                    
                    
                    DispatchQueue.main.async {
                        //self.tableView.reloadData()
                        self.refresh()
                        
                    }
                    
                    
                }
                catch let error{
                    print(error)
                }
                
            }
            
            //
        }
        task.resume()
        
        
    }
    
    
    // =========================================================================
    // MARK: - Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.beacons.count
        
       
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "beacontableviewcell", for: indexPath) as! BeaconTableViewCell
        
        print(indexPath.row)
        
        if (cell.title != nil )
        {
            print(indexPath.row)
            //cell.title.text = self.beacons[indexPath.row].title
            cell.title.text = "No title"
        }
        else {
            cell.title.text = "No title"
        }
        
        
        if (cell.desc != nil)
        {
            print(indexPath.row)
            // cell.desc.text = self.beacons[indexPath.row].desc
            cell.desc.text = "No desc"
        }
        else
        {
            cell.desc.text = "No desc"
        }
        
        if (beacons[indexPath.row].img != nil)
        {
            print(indexPath.row)
            
            cell.img.downloadImage(from: (self.beacons[indexPath.row].img!))
            
        }
        else
        {
            let img = UIImage(named: "Settings.png")
            let imageView = UIImageView(image: img)
            cell.img = imageView
            
            
        }
        
        
        
        return cell
    }
    
    
    
    
    //MARK: NAVIGATION
    
    
    func getData() {
        self.beacons.removeAll(keepingCapacity: false)
        
        self.refresh()
        
        
        
        
    }
    
    func refresh() {
        self.tableView.reloadData()
        
        self.refreshControl?.endRefreshing()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "advertisement2" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let advertisementVC = segue.destination as! AdvertisementViewController
                advertisementVC.advtext = beacons[indexPath.row].title
                
            }
        }
        
    }
    
    
    
    
    
    @IBAction func didTapSignOut(sender: AnyObject) {
        
        
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                print("User was signed in.",user)
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
                
            }
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            //
            
            
        }
    }
    
    @IBAction func back(sender: UIBarButtonItem!)
    {
        self.performSegue(withIdentifier: "back", sender: self)
    }
    
    
    
    
}




