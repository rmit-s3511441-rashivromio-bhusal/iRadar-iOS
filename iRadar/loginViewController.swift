//
//  loginViewController.swift
//  iRadar
//
//  Created by Rashiv Romio Bhusal on 24/3/17.
//  Copyright © 2017 Rashiv Romio Bhusal. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn


class loginViewController: UIViewController , GIDSignInDelegate , GIDSignInUIDelegate {
    @IBOutlet weak var SignIn: GIDSignInButton!
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
       // var apicall = BeaconTableViewController.apicall()
        setupGoogleButtons()
    }
   
  
    
    
    fileprivate func setupGoogleButtons()
    {
    
        let SignIn = UIButton(type: .system)
         SignIn.frame = CGRect(x: self.view.bounds.size.width - (166 + 66), y: self.view.bounds.size.height - (96 + 4) , width: 50, height: 50)
        view.addSubview(SignIn)
       // SignIn.backgroundColor = .white
       // SignIn.setTitle("SignIn", for: .normal)
     //  SignIn.addTarget(self, action: #selector(handleCustomGoogleSignIn) , for: .touchUpInside)
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
      
    
    }
    
    
   func  handleCustomGoogleSignIn(){
    //GIDSignIn.sharedInstance().uiDelegate = self
       // GIDSignIn.sharedInstance().signInSilently()
    GIDSignIn.sharedInstance().signIn()
   }
//    
    
    
    //
    
  
    
    // =========================================================================
    // MARK: - UIViewController
    
    
    
       //
    
    
  
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // fetchAdvertisementhere()
        
        if error != nil
        {
            print( error )
            return
        }
       
        else{
            
//            let userId = user.userID                  // For client-side use only!
//            let idToken = user.authentication.idToken // Safe to send to the server
//            let fullName = user.profile.name
//            let givenName = user.profile.givenName
//            let familyName = user.profile.familyName
//            let email = user.profile.email
//            
//            
           
            performSegue(withIdentifier: "idSegueContent", sender: self)
            print(user.profile.email)
            print(user.userID)
            print(user.profile.name)
            
            print(user.profile.imageURL(withDimension: 400))
            print("hhhhiiiiiiii")
            
            
            
           
        }
        
        
        
        guard let idToken = user.authentication.idToken
            else{
                return
        }
        guard let accesToken = user.authentication.accessToken
            else
        {
            return
        }
        
        let credentials = FIRGoogleAuthProvider.credential(withIDToken: idToken, accessToken: accesToken)
        
        FIRAuth.auth()?.signIn(with: credentials, completion: {(user , error) in
            if let err = error{
                print(" firebase failed to create Google account:",err)
                return
            }
            guard let uid = user?.uid
                else
            {
                return
            }
            
            
            print("successfully firebase login", uid)
        })
        
   
        
        }
    
   
}
