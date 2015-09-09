//
//  ViewController.swift
//  CircleDraw
//
//  Created by Trainer on 09/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ColorMixerViewControllerDelegate {

    // outlets
    @IBOutlet weak var theCircleView: CircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        print("LAYOUT WORK")
        
    }
    
    // MARK: - Navigation methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ColorMixer" {
            let mixer = segue.destinationViewController as! ColorMixerViewController
            mixer.mixedColor = theCircleView.color
            if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
                mixer.delegate = self
            }
        }
    }
    
    @IBAction func closeColorMixer(segue:UIStoryboardSegue) {
        let mixer = segue.sourceViewController as! ColorMixerViewController
        theCircleView.color = mixer.mixedColor
    }
    
    // MARK: - Delegate callbacks
    
    func colorMixerHasChangedColor(mixer mixer: ColorMixerViewController, newColor: UIColor) {
        theCircleView.color = newColor
    }

}

