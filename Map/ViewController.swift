//
//  ViewController.swift
//  Map
//
//  Created by vale on 4/2/15.
//  Copyright (c) 2015 changweitu@app660.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        if let user = PFUser.currentUser()  {
            
            println(user.username)
            
        } else {
            
            
            var loginVC:LoginViewController = LoginViewController(nibName: "LoginViewController",bundle: nil)
            self.addChildViewController(loginVC)
            self.view.addSubview(loginVC.view);
            loginVC.didMoveToParentViewController(self)
            
            
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}

