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


class AdvertisementViewController: UIViewController  {
    
    var advtext : String?
    var imagep : String?
    
   // var advertisement : Advertisement?
    
   @IBOutlet weak var adv: UILabel!
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var Signout: UIBarButtonItem!
    
    @IBOutlet weak var back: UIBarButtonItem!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let advtext = advtext {
            adv.text = advtext
        }
        
//        if let imagep = imagep {
//            pic.image = imagep.data(using: )
//        }
        
    }
    
    
    @IBAction func back(sender: UIBarButtonItem!)
    {
        self.performSegue(withIdentifier: "back", sender: self)
           }
    
    @IBAction func didTapSignOut(sender: AnyObject) {
        
        
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if case let user = user {
                print("User is signed in.")
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
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
