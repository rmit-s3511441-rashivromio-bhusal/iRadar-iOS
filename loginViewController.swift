//
//  loginViewController.swift
//  iRadar
//
//  Created by Rashiv Romio Bhusal on 23/3/17.
//  Copyright © 2017 Rashiv Romio Bhusal. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {

   
    @IBOutlet weak var usernametextfield: UITextField!
    @IBOutlet weak var passwordtextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginbuttontapped(_ sender: Any) {
        
       // let username = usernametextfield.text;
        //let password = passwordtextfield.text;
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
