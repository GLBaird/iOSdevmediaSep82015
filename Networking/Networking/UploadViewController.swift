//
//  UploadViewController.swift
//  Networking
//
//  Created by Trainer on 11/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController {

    // outlets
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var log: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Actions
    
    @IBAction func pickImage(sender: AnyObject) {
    }
    
    @IBAction func upload(sender: AnyObject) {
    }

}
