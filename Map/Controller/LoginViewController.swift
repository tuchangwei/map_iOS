//
//  LoginViewController.swift
//  Map
//
//  Created by vale on 4/2/15.
//  Copyright (c) 2015 changweitu@app660.com. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginWithFB(sender: AnyObject) {
        
        PFFacebookUtils.logInWithPermissions(nil) { (user: PFUser!, error: NSError!) -> Void in
            
            if let user = user {
                
                println("I am in from fb!")
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
            }
        }
    }
   
    @IBAction func loginWithTwitter(sender: UIButton) {
        
        PFTwitterUtils.logInWithBlock { (user: PFUser!, error: NSError!) -> Void in
            
            if let user = user {
                
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
            }
        }
    }
}
