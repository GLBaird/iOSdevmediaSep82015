//
//  ViewController.swift
//  Animation
//
//  Created by Trainer on 11/09/2015.
//  Copyright (c) 2015 Leon Baird. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var butterfly: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fadeIn(sender: AnyObject) {
        UIView.beginAnimations("fadeIn", context: nil)
        UIView.setAnimationDuration(2.0)
        UIView.setAnimationBeginsFromCurrentState(true)
        
        butterfly.alpha = 1.0
        butterfly.transform = CGAffineTransformIdentity
        
        UIView.commitAnimations()
    }

    @IBAction func fadeOut(sender: AnyObject) {
        UIView.beginAnimations("fadeOut", context: nil)
        UIView.setAnimationDuration(2.0)
        UIView.setAnimationBeginsFromCurrentState(true)
        
        butterfly.alpha = 0.0
        var matrix = CGAffineTransformMakeScale(2.0, 2.0)
        matrix = CGAffineTransformRotate(matrix, CGFloat(M_PI/2.0))
        matrix = CGAffineTransformTranslate(matrix, 300.0, 0.0)
        
        butterfly.transform = matrix
        
        UIView.commitAnimations()
    }
}

