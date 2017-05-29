//
//  AdvertisementViewController.swift
//  iRadar
//
//  Created by Rashiv Romio Bhusal on 2/5/17.
//  Copyright © 2017 Rashiv Romio Bhusal. All rights reserved.
//

import UIKit
import Firebase
import KontaktSDK
import FirebaseDatabase



class Advertisement3ViewController: UIViewController  {
    let posts = [post]
    
    var advtext : String?
    // var imagep : String?
    var imagep : UIImage?
    var pict: String?
    var beac: Beacons?
    //var commentfromUser: String?
    var submited: String?
    
    
    @IBOutlet weak var good: UIButton!
    // var advertisement : Advertisement?
    
    @IBOutlet weak var average: UIButton!
    @IBOutlet weak var bad: UIButton!
    @IBOutlet weak var adv: UILabel!
    @IBOutlet weak var pic: UIImageView!
    
    
    
    @IBOutlet weak var back: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let advtext = advtext {
            adv.text = advtext
            print(advtext)
        }
        if let pict = pict{
            pic.image = imagep
            
            
            UIGraphicsBeginImageContext(self.view.frame.size)
            //UIImage(named: pict)?.draw
            UIImage(named: "ibeaco.png")?.draw(in: self.view.bounds)
            
            let image: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            self.view.backgroundColor = UIColor(patternImage: image)
            
            print(pict)
            
            
        }
        
        
    }
    
    
    
    
    
    
    //            advertisementVC.advtext = beacons[indexPath.row].title
    //            advertisementVC.pict = beacons[indexPath.row].img
    //
    
    
    
    
    
    
    
    @IBAction func good(sender: UIButton){
        
        post()
        bad.isHidden = true
        average.isHidden = true
        
        //good.setTitle("Thank You for your review", for: .focused)
        good.setTitle("Thank You for your review", for: [.normal])
        good.isEnabled = false
    }
    
    
    @IBAction func bad(sender: UIButton){
        
        badpost()
        // good.isHidden = true
        average.isHidden = true
        good.isEnabled = false
        
        good.setTitle("Thank You for your review", for: [.normal])
        bad.isHidden = true
    }
    
    
    @IBAction func average(sender: UIButton){
        
        averagepost()
        
        
        bad.isHidden = true
        good.isEnabled = false
        
        good.setTitle("Thank You for your review", for: [.normal])
        average.isHidden = true
    }
    
    
    
    func post()
    {
        
        
        let title = "Advertisement "
        
        
        let message = "Good "
        
        let post : [String : AnyObject] = ["title": title as AnyObject ,"Name": advtext as AnyObject , "message": message as AnyObject]
        let databaseREF = FIRDatabase.database().reference()
        
        databaseREF.child("POSTS").childByAutoId().setValue(post)
        
    }
    
    
    func badpost()
    {
        let title = "Advertisement "
        
        
        let message = "Bad"
        
        let post : [String : AnyObject] = ["title": title as AnyObject ,"Name": advtext as AnyObject , "message": message as AnyObject]
        let databaseREF = FIRDatabase.database().reference()
        
        databaseREF.child("POSTS").childByAutoId().setValue(post)
    }
    
    
    func averagepost()
    {
        let title = "Advertisement "
        
        
        let message = "Normal"
        
        let post : [String : AnyObject] = ["title": title as AnyObject ,"Name": advtext as AnyObject , "message": message as AnyObject]
        let databaseREF = FIRDatabase.database().reference()
        
        databaseREF.child("POSTS").childByAutoId().setValue(post)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        //        if let imagep = imagep {
        //            pic.image = imagep.data(using: )
        //        }
        
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

