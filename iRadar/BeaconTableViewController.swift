//
//  BeaconTableViewController.swift
//  iRadar
//
//  Created by Rashiv Romio Bhusal on 3/4/17.
//  Copyright © 2017 Rashiv Romio Bhusal. All rights reserved.
//

import UIKit
import KontaktSDK
import GoogleSignIn
import Firebase

   

///


class BeaconTableViewController: UITableViewController {
    
   
     
   
    @IBOutlet weak var SignOut: UIBarButtonItem!
    var beacons : [Beacons]? = []
    

    
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
               apicall()
     
    }
    
    func loadList(notification: NSNotification){
        //load data here
        self.tableView.reloadData()
    }
        
        
        func apicall(){
            
            //NEW C/haNGES HERE
            //CHECK IF ITS WORKING OR NOT
            print("CHECKING THE IMAGES LOADED")
                NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
            print("CHECKING THE IMAGES LOADED HERE OR NOT")

        let apiClient = KTKCloudClient.sharedInstance()
        
      //  let parameters = ["uniqueId": "4tla"]
        
        
          let parameters: [String: String] = [ "uniqueId": "rTJz, 4tla, oHdN" ]
        
        apiClient.getObjects(KTKAction.self, parameters: parameters) { (response, error) in
            if let cloudError = KTKCloudErrorFromError(error) {
                print(cloudError.debugDescription)
            } else if let actions = response?.objects as? [KTKAction] {
                for action in actions {
                    switch action.type {
                    case .browser:
                        if let url = action.url {
                            if let devicesUniqueID = action.devicesUniqueID?.contains("4tla"){
                                
                            
                            print("Browser Action for URL: \(url)")
                              print("B Action for URL: \(devicesUniqueID)")
                            self.fetchAdvertisement()
                            }
                        }
                    case .content:
                       // if let contentAction = action.content, let url = contentAction.contentURL {
                         //   print("Contant Action. Content URL: \(url)")
                        if let contentAction = action.content{
                            if let devicesUniqueID = action.devicesUniqueID?.contains("4tla"){

                            print("Contant Action. Content URL: \(contentAction)")
                                print(" Action. Content : \(devicesUniqueID)")
                              
                            
 
                            self.fetchAdvertisement()
                            }
                        }
                    case .invalid:
                        print("Invalid action")
                    }
                    
                    
                    
                    
                    
                    
                }
            }
        }
    }
  

    

    
    
    // =========================================================================
    // MARK: - UIViewController
   
  
    // =========================================================================
    // MARK: - GET IMAGES FROM URL
    public func fetchAdvertisement(){
        print("EHU 1")
        
        
        let myUrl = URL(string: "https://api.kontakt.io/action?uniqueId");
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
            }
                       //change here
            
            
            if error != nil {
                print(error as Any)
                return
            }
            
            
            self.beacons = [Beacons]()
            
            do{
                
              //  let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                

                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : AnyObject]
                
                if let actionsFromJson = json["actions"] as? [[String : AnyObject]]
                {
                    
                    for actionsFromJson in actionsFromJson {
                        
                        let beacon = Beacons()
                        
                      //  if let uniquieID = actionsFromJson["deviceUniqueIds"] as? String{
                            
                        
                        if let title = actionsFromJson["actionType"] as? String ,let desc = actionsFromJson["proximity"] as? String , let img = actionsFromJson["url"] as? String {
                            
                           
                        //   print(uniquieID)
                          
                            print(title)
                            print(desc)
                            print(title)
                            
                            beacon.title = title
                            beacon.desc = desc
                            beacon.img = img
                            
                                
                           }
                              
                            
                        else if let title = actionsFromJson["actionType"] as? String ,let desc = actionsFromJson["proximity"] as? String , let img = actionsFromJson["content"] as? String {
                            
                            
                          //  print(uniquieID)

                            print(title)
                            print(desc)
                            print(title)
                            
                            beacon.title = title
                            beacon.desc = desc
                            beacon.img = img
                        }
                            
                        
                            
                            self.beacons?.append(beacon)
                        }
                        
                    }
            
                DispatchQueue.main.async {
                    self.tableView.reloadData()

                }
                
                
            }
            catch let error{
                print(error)
            }
                
            }
        task.resume()
        
        
        }
        
   
    
  
    
    // =========================================================================
    // MARK: - Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
               return self.beacons?.count ?? 0
        
        //return self.beacons?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "beacontableviewcell", for: indexPath) as! BeaconTableViewCell
        
        
        
        cell.title.text = self.beacons?[indexPath.item].title 
        cell.desc.text = self.beacons?[indexPath.item].desc
        cell.img.downloadImage(from: (self.beacons?[indexPath.item].img!)!)
        
       
        return cell
    }
    
    //MARK: NAVIGATION
    
    
   
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "advertisement" {
            if let indexPath = tableView.indexPathForSelectedRow{
               let advertisementVC = segue.destination as! AdvertisementViewController
                    advertisementVC.advtext = beacons?[indexPath.row].title
                    advertisementVC.imagep = beacons?[indexPath.row].img
    
            }
                        }
           
            }
    
    
    

    
    @IBAction func didTapSignOut(sender: AnyObject) {
        
        
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if case let user = user {
                print("User was signed in.")
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
    
    
    
    
    
}





extension UIImageView{
    
        func downloadImage(from url: String)
        {
        
            let urlRequest = URLRequest(url: URL(string: url)!)
        
        
            let task = URLSession.shared.dataTask(with: urlRequest)
            {
                (data,response,error) in
                guard let data = data , error == nil else {
                    return
                }
                if error != nil
                {
                    print(error!)
                    return
                }
                 DispatchQueue.main.async
                        {
                            self.image = UIImage(data : data)
                        }
            }
        
        task.resume()
    
        }
                    }


extension Collection where Indices.Iterator.Element == Index {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Generator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
