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
        if let instance = User.instance() {
            
           println("\(instance.userEmail)")
            
        } else {
            
//            var user = User(userName: "vale", userEmail: "1@1.com")
//            user.store()
            var loginVC:LoginViewController = LoginViewController(nibName: "LoginViewController",bundle: nil)
            self.view.addSubview(loginVC.view);
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}

