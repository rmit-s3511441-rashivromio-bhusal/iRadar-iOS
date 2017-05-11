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
   
    @IBOutlet weak var im: UIImageView!
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
      // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "ibeaco.png")!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)))
        
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "ibeaco.png")?.draw(in: self.view.bounds)
        
        var image: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
        
    }
    
        
        
        
    

    
    
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
        
        
        var im: UIImage?
        var profile: String?
        if error != nil
        {
           
            
            print( error )
            return
        }
       
            
        else{
            
//          let userId = user.userID                  // For client-side use only!
//           let idToken = user.authentication.idToken // Safe to send to the server
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
            print("pic", user.profile.imageURL(withDimension: 400))
            
                                  print("hhhhiiiiiiii")
            
            if GIDSignIn.sharedInstance().currentUser.profile.hasImage
            {
                print("Account Has Image")
                print("pic", user.profile.imageURL(withDimension: 400))

                
                ////Profile Photo
                
                
                
                guard let pic = GIDSignIn.sharedInstance().currentUser.profile.imageURL(withDimension: 400) , let data = NSData(contentsOf: pic) as Data? else {
                    print("missing picture with the dimension:")
                    return
                }
                
               self.im?.image = UIImage(data: data)
              
            }
            if (GIDSignIn.sharedInstance().currentUser.profile.email != nil){
                var email = user.profile.email

                 print("Account Has address")
                print("geeee", user.profile.email)
                guard (GIDSignIn.sharedInstance().currentUser.profile.email) != nil else {
                    print("geeee", user.profile.email)
                    return
                }
                email = profile
                profile = user.profile.email
                
            }
           
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
    
  /*
    let parameters = ["special":"f7826da6-4fa2-4e98-8024-bc5b71e0893e", "customer": user.profile.email] as Dictionary<String, String>
    
    //create the url with URL
    let url = URL(string: "http://myServerName.com/api")! //change the url
    
    //create the session object
    let session = URLSession.shared
    
    //now create the URLRequest object using the url object
    var request = URLRequest(url: url)
    request.httpMethod = "POST" //set http method as POST
    
    
    let myUrl = URL(string: "https://iradar-dev.appspot.com/api/impression");
    var request = URLRequest(url:myUrl!);
    
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
            //
            //                DispatchQueue.main.async {
            //                 //   self.tableView.reloadData()
            //
            //                }
            //
            
        }
        catch let error{
            print(error)
        }
    }
    task.resume()
}

*/



}
