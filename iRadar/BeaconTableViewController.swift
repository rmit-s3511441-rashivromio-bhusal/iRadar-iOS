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
import Social



///


class BeaconTableViewController: UITableViewController {
    
    
    @IBOutlet weak var click: UIButton!
    
   
    @IBOutlet weak var back: UIButton!
    
    @IBOutlet weak var SignOut: UIButton!
       // var beacons : [Beacons]? = []
    
    var beacons : [Beacons] = []
    
   //  var beaconImages =  [String: UIImage]()
    
    //var beacons : [[Beacons: Beacons]]? = []
    
    
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
        tableView.estimatedRowHeight = 275
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        // refreshControl -> pull to refresh handler
        let refreshControl = UIRefreshControl()
        self.refreshControl = refreshControl
        post1()
        fetchAdvertisement()
        
    }
    
    
    
    func loadList(notification: NSNotification){
        //load data here
        self.tableView.reloadData()
    }
    
 /*
    func apicall(){
        
        //NEW C/haNGES HERE
        //CHECK IF ITS WORKING OR NOT
        print("CHECKING THE IMAGES LOADED")
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        print("CHECKING THE IMAGES LOADED HERE OR NOT")
        
        let apiClient = KTKCloudClient.sharedInstance()
        
        let parameters = ["uniqueId": "4tla"]
        
        
        // let parameters: [String: String] = [ "uniqueId": "rTJz, 4tla, oHdN" ]
        
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
                            
                            
//                            
//                                                      else if let devicesUniqueID = action.devicesUniqueID?.contains("oHdN"){
//                            
//                            
//                                                            print("Browser Action for URL: \(url)")
//                                                            print("B Action for URL: \(devicesUniqueID)")
//                            
//                                                            self.fetchOHDN()
//                                                        }
//                            
//                            //  if KTKBeaconManager.isRangingAvailable() {
//                            
//                            
//                           else if let devicesUniqueID = action.devicesUniqueID?.contains("rTJz"){
//                                
//                                
//                                print("Browser Action for URL: \(url)")
//                                print("B Action for URL: \(devicesUniqueID)")
//                                print(action.actionID)
//                                
//                                
//                                self.fetchrTJz()
//                                //  }
//                                // }
//                            }
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
                            
//                            
//                                                  else  if let devicesUniqueID = action.devicesUniqueID?.contains("oHdN"){
//                            
//                                                        print("Contant Action. Content URL: \(contentAction)")
//                                                        print(" Action. Content : \(devicesUniqueID)")
//                            
//                            
//                            
//                                                        self.fetchOHDN()
//                                                    }
//                            
//                            
//                            
//                            //
//                           else if let devicesUniqueID = action.devicesUniqueID?.contains("rTJz"){
//                                
//                                print("Contant Action. Content URL: \(contentAction)")
//                                print(" Action. Content : \(devicesUniqueID)")
//                                
//                                
//                                
//                                
//                                self.fetchrTJz()
//                            }
                            
                        }
                        
                    case .invalid:
                        print("Invalid action")
                    }
                    
                    
                    
                    
                    
                    
                }
            }
        }
    }
    
    
    
    */
    
    
     
     // =========================================================================
     // MARK: - UIViewController
     
     
     // =========================================================================
     // MARK: - GET IMAGES FROM URL
     public func fetchAdvertisement(){
     print("EHU 1")
     
        
        let myUrl = URL(string: "https://iradar-dev.appspot.com/api/beacon-specials?major=8076&minor=17108");
     //let myUrl = URL(string: "https://iradar-dev.appspot.com/api/beacon-specials?major=57656&minor=64688");
     var request = URLRequest(url:myUrl!);
     request.httpMethod = "GET";
     request.addValue("tmwNSX5uC4JjVnZsUZFnKcJW", forHTTPHeaderField: "Api-Key")
     request.addValue("application/json", forHTTPHeaderField: "Content-Type")
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
     
     
     if let actionsFromJson = json["specials"] as? [[String : AnyObject]]
     {
     
     
     
     for actionsFromJson in actionsFromJson {
     
     let beacon = Beacons()
     
     //                       for (key, value) in actionsFromJson {
     //                      print("\(key) -> \(value)")
     
     // for value in actionsFromJson.values {
     //   print("\(value)")
     
     // if let deviceUniqueIds = actionsFromJson["devicesUniqueID"]?.contains("4tla") {
     
     // let uniqueId = actionsFromJson["deviceUniqueIds"]?["4tla"] as? String
     
     if let title = actionsFromJson["name"] as? String ,let desc = actionsFromJson["proximity"] as? String , let img = actionsFromJson["url"] as? String {
     
     // print(deviceUniqueIds)
     //  print(uniqueId)
     //  print(title)
     // print(desc)
     // print(title)
     
     beacon.title = title
     beacon.desc = desc
     beacon.img = img
     
     }
     
     
     
     else if let title = actionsFromJson["name"] as? String ,let desc = actionsFromJson["proximity"] as? String , let img = actionsFromJson["content"] as? String  {
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
    
    
    
    
    
    func post1()
    {
        if let currentUser = GIDSignIn.sharedInstance().currentUser{
            //   GIDSignIn.sharedInstance().signIn()
            let name = currentUser.profile.name!
            let email = currentUser.profile.email!
            let major = 8076
            let beacon = "4tla"
            let special = "5739407210446848"
            
            let parameter = ["major": major, "beacon" : beacon ,"name" : name, "special": special ,"customer": email] as [String: Any]
            
            
            let myUrl = URL(string: "https://iradar-dev.appspot.com/api/impression");
            var request = URLRequest(url:myUrl!);
            
            //Do we really need this poststring//
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
                    
                    DispatchQueue.main.async {
                        //   self.tableView.reloadData()
                        
                    }
                    
                    
                }
                catch let error{
                    print(error)
                }
            }
            task.resume()
        }
        

    }
    
    
    
    
    
    // =========================================================================
    // MARK: - Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // return (self.beacons?.count)!
        
        return self.beacons.count
        
        //   return self.beacons?.count ?? 0
        
        //return self.beacons?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "beacontableviewcell", for: indexPath) as! BeaconTableViewCell
       // let tapGesture = UITapGestureRecognizer (target: self, action: #selector(imgTap(tapGesture:)))
        
        
        print(indexPath.row)
       /*
        cell.title.text = self.beacons[indexPath.item].title
        cell.desc.text = self.beacons[indexPath.item].desc
        cell.img.downloadImage(from: (self.beacons[indexPath.item].img!))
        
        
        
        //        cell.title.text = self.beacons?[indexPath.item].title
        //        cell.desc.text = self.beacons?[indexPath.item].desc
        //        cell.img.downloadImage(from: (self.beacons?[indexPath.item].img!)!)
        */
        
        
        if (cell.title != nil )
        {
            print(indexPath.row)
            cell.title.text = self.beacons[indexPath.row].title
            
        //cell.title.text = "No title"
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
        
        if (cell.img == nil)
        {
            print(indexPath.row)
            let img = UIImage(named: "Settings.png")
            let imageView = UIImageView(image: img)
            cell.img = imageView
            
                    }
          else if (cell.img != nil)
            {
                 print(indexPath.row)
                cell.img.downloadImage(from: (self.beacons[indexPath.row].img!))
                print(indexPath.row)
                
            }
        
            
    
    
            
            //cell.img.downloadImage(from: (self.beacons[indexPath.row].img!))
            
        
//                else
//                {
//                        let img = UIImage(named: "Settings.png")
//                        let imageView = UIImageView(image: img)
//                        cell.img = imageView
//                    
//            
//                }

    
          //  cell.img.downloadImage(from: (self.beacons[indexPath.row].img!))
        
       
        
        return cell
    }
    
    //IMAGE
    
    func imgTap(tapGesture: UITapGestureRecognizer) {
       // let imgView = tapGesture.view as! UIImageView
     //   let idToMove = imgView.tag
        //Do further execution where you need idToMove
        
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
        if segue.identifier == "showdetail" {
//            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                let advertisementVC = segue.destination as! AdvertisementViewController
                
               if let indexPath = self.tableView.indexPathForSelectedRow{
                
               // let dvc = segue.destinationViewController as! ListPage
//                dvc.newImage = postingImage.image
               
                
         
               // advertisementVC.newImage = Beacons.img

                
                advertisementVC.advtext = beacons[indexPath.row].title
                
                advertisementVC.pict = beacons[indexPath.row].img
                
                
                
                               // advertisementVC.imagep = downloadImage(from: (self.beacons[indexPath.row].img!))

               // advertisementVC.pic = beaconatIndexPath[indexPath]
                
            }
        }
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beacontableviewcell", for: indexPath) as! BeaconTableViewCell
        
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal , title: "Click to Share"){
            
            (rowaction , IndexPath) -> Void in
            
            let shareActionSheet = UIAlertController(title: nil,message:"Share With",preferredStyle: .actionSheet)
            
            let facebookshareAction  = UIAlertAction(title: "Facebook", style: .default) { (action) -> Void in
                
                if
                    SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook)
                    
                {
                    let fbComposer = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                    fbComposer?.add(cell.img.image!)
                    
                    fbComposer?.setInitialText("I love this")
                    self.present(fbComposer!, animated: true, completion: nil)
                }
                    
                else
                {
                    let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)

                }
                
                
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel , handler: nil)
            shareActionSheet.addAction(facebookshareAction)
            shareActionSheet.addAction(cancelAction)
            self.present(shareActionSheet, animated: true, completion: nil)
            
        }
        let hi = UIColor(red:65/255.0, green:105/255.0, blue:226/255.0, alpha:1.0)
        
        shareAction.backgroundColor = hi
        
        return [shareAction]
    }
    
    
    func alert(title: String , msg : String)
    {
        let alertVC = UIAlertController(title: title,message : msg, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style : .default ,handler: nil))
        self.present(alertVC, animated: true, completion: nil)
        
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
    
    @IBAction func back(sender: AnyObject!)
    {
        self.performSegue(withIdentifier: "back", sender: self)
    }
    
    
 
}




//extension UIImageView{
//    
//    func downloadImage(from url: String)
//    {
//        print("download function reached")
//       
//        let urlRequest = URLRequest(url: URL(string: url)! )
//        
//        
//        let task = URLSession.shared.dataTask(with: urlRequest)
//        {
//            (data,response,error) in
//            guard let data = data , error == nil else {
//                NSLog("Image download error: \(String(describing: error))")
//                
//                return
//            }
//            if error != nil
//            {
//                print(error!)
//                return
//            }
//            //                 DispatchQueue.main.async
//            //                        {
//            //                            self.image = UIImage(data : data)
//            //                        }
//            
//            
//            DispatchQueue.main.async(execute: { () -> Void in
//                if let image = UIImage(data: data) {
//                    NSLog("Image download success")
//                    self.image = image
//                
//                    
//                }
//                    
//                else {
//                    self.image = UIImage(named : "Home.png")
//                    NSLog("Image download unsuccess")
//                }
//                
//                
//            })
//            
//            
//            
//            
//            
//            /*
//             
//             dispatch_async(dispatch_get_main_queue(), {
//             if let cell: YourTableViewCell = tableView.cellForRowAtIndexPath(indexPath) as? YourTableViewCell {
//             cell.cardPreview.image = image
//             }
//             })
//             } else {
//             cell.cardPreview.image = UIImage(named: "defaultImage")
//             }
//             
//             
//             */
//            
//            
//            
//        }
//        
//        task.resume()
//        
//    }
//}
//
//
//extension Collection where Indices.Iterator.Element == Index {
//    
//    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
//    subscript (beacons: Index) -> Generator.Element? {
//        return indices.contains(beacons) ? self[beacons] : nil
//    }
//}
