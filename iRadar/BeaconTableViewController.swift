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
    
    var beacons : [Beacons]? = []
    

    
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
                            print("Browser Action for URL: \(url)")
                            
                            self.fetchAdvertisement()
                            
                        }
                    case .content:
                        if let contentAction = action.content, let url = contentAction.contentURL {
                            print("Contant Action. Content URL: \(url)")
                            
                            self.fetchAdvertisement()
                            
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
                        
                        if let title = actionsFromJson["actionType"] as? String ,let desc = actionsFromJson["proximity"] as? String , let img = actionsFromJson["url"] as? String {
                            
                            print(title)
                            print(desc)
                            print(title)
                            
                            beacon.title = title
                            beacon.desc = desc
                            beacon.img = img
                            
                                
                                
                              
                            }
                        else if let title = actionsFromJson["actionType"] as? String ,let desc = actionsFromJson["proximity"] as? String , let img = actionsFromJson["content"] as? String {
                            
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
