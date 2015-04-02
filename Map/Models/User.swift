//
//  User.swift
//  Map
//
//  Created by vale on 4/2/15.
//  Copyright (c) 2015 changweitu@app660.com. All rights reserved.
//

import UIKit

class User: NSObject, NSCoding {
   
    
    let userName:String
    let userEmail:String
    init(userName: String, userEmail:String) {
        
        self.userName = userName;
        self.userEmail = userEmail;
        super.init()
    }
    
    func store() {
        
        let userDefault = NSUserDefaults.standardUserDefaults();
        let archivedUser:NSData = NSKeyedArchiver.archivedDataWithRootObject(self)
        userDefault.setObject(archivedUser, forKey: "user")
    }
    class func instance() -> User?{
        
        let userDefault = NSUserDefaults.standardUserDefaults();
        let data:NSData? = userDefault.objectForKey("user") as? NSData
        if data != nil {
            
            let user = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as User
            return user
        }
        return nil
    }
    
    
    //NSCodeing Protocol
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(self.userName, forKey: "userName")
        aCoder.encodeObject(self.userEmail, forKey: "userEmail")
    }
    required init(coder aDecoder: NSCoder) {
        
        self.userName = aDecoder.decodeObjectForKey("userName") as String
        self.userEmail = aDecoder.decodeObjectForKey("userEmail") as String
        
    }
}
