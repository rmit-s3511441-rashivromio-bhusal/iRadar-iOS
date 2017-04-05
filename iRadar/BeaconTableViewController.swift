//
//  BeaconTableViewController.swift
//  iRadar
//
//  Created by Rashiv Romio Bhusal on 3/4/17.
//  Copyright © 2017 Rashiv Romio Bhusal. All rights reserved.
//

import UIKit

class BeaconTableViewController: UITableViewController {
    

   //var beacons = [Beacons]()
   
    
    var beacons : [Beacons]? = []
  //  var beacons = ["4tla", "rTJz", "oHdN"]
  
   // let cellIdentifier = "BeaconTableViewCell"
    
    // =========================================================================
    // MARK: - UIViewController
   
    
    override func viewDidLoad() {
        // Super
        super.viewDidLoad()
        
        fetchAdvertisement()
            print("EHU")
        
        
        
    }
    
    private func fetchAdvertisement(){
        print("EHU 1")
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v1/articles?source=techcrunch&sortBy=top&apiKey=c035c70501304481b56d98f33c221899")!)
        
       
       // let urlRequest = URLRequest(url: URL(string: " https://api.kontakt.io/action?uniqueId=4tla&apiKey=vnrXRFJARjeLgIVLBeqmHkXMxXEVsNRm")!)
        
       
        
        
        
        
        
        print("EHU 2 ")
        let task = URLSession.shared.dataTask(with: urlRequest)
        {
            
            (data,response,error) in
            
            
            if error != nil {
                print(error)
                return
            }
            
            
            self.beacons = [Beacons]()
            
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                    if let articlesFromJson = json["articles"] as? [[String : AnyObject]]
                        {
                            
                        for articlesFromJson in articlesFromJson {
                            
                            let beacon = Beacons()
                            
                        // if let resultFromJson = json["result"] as? [[String : AnyObject]]

                            //  if let specials = resultFromJson["result"] as? String, let specials=resultFromJson["uid"]as?String, let desc =responseFromJson["response"]
                            //result,specials,uid,name ,url
                            
                            
                            
                            if let title = articlesFromJson["title"] as? String ,let desc = articlesFromJson["description"] as? String , let img = articlesFromJson["urlToImage"] as? String {
                                
                     
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
