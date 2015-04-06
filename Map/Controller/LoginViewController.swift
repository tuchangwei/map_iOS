//
//  LoginViewController.swift
//  Map
//
//  Created by vale on 4/2/15.
//  Copyright (c) 2015 changweitu@app660.com. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate {
    
    func afterlogin()
}


let ttScreenNameKey = "screenName"
class LoginViewController: UIViewController {

    var delegate:LoginViewControllerDelegate?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginWithFB(sender: AnyObject) {
        
        PFFacebookUtils.logInWithPermissions(nil) { (user: PFUser!, error: NSError!) -> Void in
            
            if var user = user {
                println("I am in from fb!")
                
                let session:FBSession = PFFacebookUtils.session()
                let me:FBRequest = FBRequest(session:session, graphPath:"me")
                me.startWithCompletionHandler({ (connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
                    
                    if let graphObject = result as? FBGraphObject {
                        
                        if let name = graphObject["name"] as? String {
                            
                            user.setObject(name, forKey: "screenName")
                            user.saveInBackgroundWithBlock({ (sueesee:Bool, error:NSError!) -> Void in
                                
                                println("add screen Name")
                            })

                        }
                        
                    }
                    
                })
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
                self.delegate?.afterlogin()
            }
        }
    }
   
    @IBAction func loginWithTwitter(sender: UIButton) {
        
        PFTwitterUtils.logInWithBlock { (user: PFUser!, error: NSError!) -> Void in
            
            if var user = user {
                
                user.setObject(PFTwitterUtils.twitter().screenName, forKey: ttScreenNameKey)
                user.saveInBackgroundWithBlock({ (sueesee:Bool, error:NSError!) -> Void in
                    
                    println("add screen Name")
                })
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
                self.delegate?.afterlogin()
            }
        }
    }
}
