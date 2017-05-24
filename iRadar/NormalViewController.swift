//
//  NormalViewController.swift
//  iRadar
//
//  Created by Rashiv Romio Bhusal on 23/5/17.
//  Copyright © 2017 Rashiv Romio Bhusal. All rights reserved.
//

import UIKit

class NormalViewController: UIViewController {

    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var show: UIButton!
    
   
    
    //var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func show(sender : UIButton){
        
                   self.performSegue(withIdentifier: "view", sender: self)
                
        
    }
    
    
    @IBAction func back(sender: AnyObject!)
    {
        self.performSegue(withIdentifier: "back", sender: self)
    }

    
//        if nametxt.text == "" || emailtxt.text == "" {
//            let alert = UIAlertController(title: "Empty", message: "All fields need to be filled", preferredStyle: UIAlertControllerStyle.alert)
//            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
//        else {
//            
//            
//            self.performSegue(withIdentifier: "view", sender: self)
//        }
//
        
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
        
    
        
    
    }
    


