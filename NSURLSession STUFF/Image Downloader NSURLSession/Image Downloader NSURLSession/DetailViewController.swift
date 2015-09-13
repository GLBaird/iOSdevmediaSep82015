//
//  DetailViewController.swift
//  Image Downloader NSURLSession
//
//  Created by Leon Baird on 12/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    var image:FlickrImage?
    var startSize:CGSize?
    
    @IBOutlet weak var scrollView: UIScrollView!
    var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let image = self.image {
            navigationItem.title = image.name
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            image.getImage(.Full, callBack: {
                imageFinal in
                self.imageView = UIImageView(
                    image:imageFinal
                )
                self.centreImageInScrollView(1)
                self.scrollView.addSubview(self.imageView!)
                self.scrollView.contentSize = self.imageView.frame.size
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - ScrollView Zoom Method
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    /*
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        centreImageInScrollView(scale)
    }
    */
    
    func centreImageInScrollView(scale:CGFloat) {
        imageView.frame.origin.x = scrollView.bounds.width/2 - imageView.image!.size.width*scale/2
        imageView.frame.origin.y = scrollView.bounds.height/2 - imageView.image!.size.height*scale/2 - 64
    }
}
