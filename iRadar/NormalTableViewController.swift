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


class NormalTableViewController: UITableViewController {
    

  
    @IBOutlet weak var back: UIBarButtonItem!
    
    @IBOutlet weak var Share: UIButton!
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
                            
                            
                            if let title = actionsFromJson["name"] as? String ,let desc = actionsFromJson["proximity"] as? String , let img = actionsFromJson["url"] as? String {
                                
                                beacon.title = title
                                beacon.desc = desc
                                beacon.img = img
                                
                            }
                                
                                
                                
                            else if let title = actionsFromJson["name"] as? String ,let desc = actionsFromJson["proximity"] as? String , let img = actionsFromJson["content"] as? String  {
                                
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
            let name = "Anonymous"
            let major = 8076
            let beacon = "4tla"
            let special = "5739407210446848"
            
            let parameter = ["major": major, "beacon" : beacon , "special": special ,"customer": name] as [String: Any]
            
            
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "normalbeacontableviewcell", for: indexPath) as! NormalBeaconTableViewCell
        
        
        print(indexPath.row)
        
        
        if (cell.title != nil )
        {
            print(indexPath.row)
            cell.title.text = self.beacons[indexPath.row].title
            
            //cell.title.text = "No title"
        }
        else {
            cell.title.text = "No title"
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
        
        
        
        
        
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "normalbeacontableviewcell", for: indexPath) as! NormalBeaconTableViewCell
        
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
            let NadvertisementVC = segue.destination as! NormalAdvertisementViewController
            
            if let indexPath = self.tableView.indexPathForSelectedRow{
                
                
                
                NadvertisementVC.advtext = beacons[indexPath.row].title
                
                NadvertisementVC.pict = beacons[indexPath.row].img
                
                
                
                
            }
        }
        
    }
    
    
    
    
       
    @IBAction func back(sender: AnyObject!)
    {
        self.performSegue(withIdentifier: "back", sender: self)
    }
    
    
    
}


