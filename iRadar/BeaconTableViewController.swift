//
//  BeaconTableViewController.swift
//  iRadar
//
//  Created by Rashiv Romio Bhusal on 3/4/17.
//  Copyright © 2017 Rashiv Romio Bhusal. All rights reserved.
//

import UIKit
import KontaktSDK

   

///


class BeaconTableViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let apiClient = KTKCloudClient.sharedInstance()
        
        let parameters = ["uniqueId": "4tla"]
        
        apiClient.getObjects(KTKAction.self, parameters: parameters) { (response, error) in
            if let cloudError = KTKCloudErrorFromError(error) {
                print(cloudError.debugDescription)
            } else if let actions = response?.objects as? [KTKAction] {
                for action in actions {
                    switch action.type {
                    case .browser:
                        if let url = action.url {
                            print("Browser Action for URL: \(url)")
                           
                        }
                    case .content:
                        if let contentAction = action.content, let url = contentAction.contentURL {
                            print("Contant Action. Content URL: \(url)")
                          
                        }
                    case .invalid:
                        print("Invalid action")
                    }
                }
            }
        }
        
        fetchAdvertisement()
        print("EHU")
    }
  

    

   //var beacons = [Beacons]()
   
    
    var beacons : [Beacons]? = []
  //  var beacons = ["4tla", "rTJz", "oHdN"]
  
   // let cellIdentifier = "BeaconTableViewCell"
    
    // =========================================================================
    // MARK: - UIViewController
   
  
    
    private func fetchAdvertisement(){
        print("EHU 1")
        
        
        let myUrl = URL(string: "https://api.kontakt.io/action?uniqueId=4tla");
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
            
            
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
            }

            
            if error != nil {
                print(error as Any)
                return
            }
            
            
            self.beacons = [Beacons]()
            
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let actionsFromJson = json["actions"] as? [[String : AnyObject]]
                {
                    
                    for actionsFromJson in actionsFromJson {
                        
                        let beacon = Beacons()
                        
                        // if let resultFromJson = json["result"] as? [[String : AnyObject]]
                        
                        //  if let specials = resultFromJson["result"] as? String, let specials=resultFromJson["uid"]as?String, let desc =responseFromJson["response"]
                        //result,specials,uid,name ,url
                        
                        
                        
                        if let title = actionsFromJson["proximity"] as? String ,let desc = actionsFromJson["deviceUniqueIds"] as? String , let img = actionsFromJson["url"] as? String {
                            
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
       // cell.img.downloadImage(from: (self.beacons?[indexPath.item].img!)!)
        
        return cell
    }
    
    
        
   
    
}



extension UIImageView{
    
        func downloadImage(from url: String)
        {
        
            let urlRequest = URLRequest(url: URL(string: url)!)
        
        
            let task = URLSession.shared.dataTask(with: urlRequest)
            {
                (data,response,error) in
                if error != nil
                {
                    print(error)
                    return
                }
            
                    DispatchQueue.main.async
                        {
                            self.image = UIImage(data : data!)
                        }
            }
        
        task.resume()
    
        }
                    }
