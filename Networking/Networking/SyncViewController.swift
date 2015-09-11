//
//  SyncViewController.swift
//  Networking
//
//  Created by Trainer on 11/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class SyncViewController: UIViewController {
    
    // outlets
    @IBOutlet weak var scrollView: UIScrollView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Actions
    
    @IBAction func downloadSYNC(sender: AnyObject) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let imageURL = NSURL(string: "http://leonbaird.co.uk/iphone/large.jpg")!
        if let downloadedImageData = NSData(contentsOfURL: imageURL) {
            let image = UIImage(data: downloadedImageData)!
            let imageView = UIImageView(image: image)
            scrollView.addSubview(imageView)
            scrollView.contentSize = image.size
        } else {
            print("Failed to download image")
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
    }
    
    @IBAction func downloadASYNC(sender: AnyObject) {
        let imageURL = NSURL(string: "http://leonbaird.co.uk/iphone/large.jpg")!
        let backgroundQueue = dispatch_queue_create("download_image", nil)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        dispatch_async(backgroundQueue, {
            let downloadedImageData = NSData(contentsOfURL: imageURL)
            
            dispatch_async(dispatch_get_main_queue(), {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                if downloadedImageData != nil {
                    let image = UIImage(data: downloadedImageData!)!
                    let imageView = UIImageView(image: image)
                    self.scrollView.addSubview(imageView)
                    self.scrollView.contentSize = image.size
                } else {
                    print("Failed to download image")
                }
            })
            
        })
    }

}
