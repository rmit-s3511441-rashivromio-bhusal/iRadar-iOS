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
       // loadSampleBeacons()
        print("EHU")
        
        
        
    }
    
    private func fetchAdvertisement(){
        print("EHU 1")
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v1/articles?source=techcrunch&sortBy=top&apiKey=c035c70501304481b56d98f33c221899")!)
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
                            
                            
                            
                            if let title = articlesFromJson["title"] as? String ,let desc = articlesFromJson["description"] as? String {
                                
                     
                               beacon.title = title
                            beacon.desc = desc
                                
                                
                              
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
        
    

    
    //MARK: Private Methods
    
   /* private func loadSampleBeacons() {
        
        
        
        
        
        
        let photo1 = UIImage(named: "Beacons1")
        let photo2 = UIImage(named: "Beacons2")
        
        guard let Beacons1 = Beacons(name: "1st Beacon", photo: photo1) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let Beacons2 = Beacons(name: "2nd Beacon", photo: photo2) else {
            fatalError("Unable to instantiate meal2")
        }
        
        // beacons += [Beacons1, Beacons2]
        
    }
    
    */
        

    
  
    
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
        
        
        
        return cell
    }
    
    
        
   
    
}

