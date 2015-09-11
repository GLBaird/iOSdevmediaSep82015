//
//  DetailViewController.swift
//  Places of Interest
//
//  Created by Trainer on 11/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit
import Social

class DetailViewController: ToolbarViewController {
    
    // outlets
    @IBOutlet weak var placeImage:UIImageView!
    @IBOutlet weak var placeDesctipion:UITextView!
    
    // model
    var place:Place?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = place?.placeName
        placeDesctipion.text = place?.placeDescription
        if place?.imagePath != "" {
            placeImage.image = UIImage(contentsOfFile: NSHomeDirectory()+place!.imagePath!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action methods
    
    @IBAction func postToSocialNetwork(sender:UIBarButtonItem) {
        let service = sender.tag == 0 ? SLServiceTypeFacebook : SLServiceTypeTwitter
        let post = SLComposeViewController(forServiceType: service)
        post.setInitialText("I visited \(place!.placeName!) on \(place!.shortDate)")
        post.addImage(placeImage.image)
        presentViewController(post, animated: true, completion: nil)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Map" {
            let mapVC = segue.destinationViewController as! MapViewController
            mapVC.place = place
        }
    }
    

}
