//
//  Model.swift
//  Archives
//
//  Created by Trainer on 11/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import Foundation

class Model: NSObject, NSCoding {

    var userName = "BOB"
    var password = "BOB"
    
    init(userName:String, password:String) {
        self.userName = userName
        self.password = password
    }
    
    required init?(coder aDecoder: NSCoder) {
        userName = aDecoder.decodeObjectForKey("username") as! String
        password = aDecoder.decodeObjectForKey("password") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(userName, forKey: "username")
        aCoder.encodeObject(password, forKey: "password")
    }
    
}
