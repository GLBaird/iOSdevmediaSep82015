//
//  Functions.swift
//  Places of Interest
//
//  Created by Trainer on 10/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

func ShowAlertWithTitle(title:String, message:String, button:String, viewController:UIViewController) {
    if #available(iOS 8.0, *) {
        print("Running iOS 8>")
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .Alert
        )
        alert.addAction(
            UIAlertAction(
                title: button,
                style: .Cancel,
                handler: nil
            )
        )
        
        viewController.presentViewController(alert, animated: true, completion: nil)
        
    } else {
        let alert = UIAlertView(
            title: title,
            message: message,
            delegate: nil,
            cancelButtonTitle: button
        )
        
        alert.show()
    }
}
