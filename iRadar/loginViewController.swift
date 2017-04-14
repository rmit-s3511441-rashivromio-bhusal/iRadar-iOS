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
        GIDSignIn.sharedInstance().signInSilently()
   }
//    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error != nil
        {
            print( error )
            return
        }
        else{
            performSegue(withIdentifier: "idSegueContent", sender: self)
            print(user.profile.email)
            print(user.profile.imageURL(withDimension: 400))
        }
        
        
        
        
        }


}
