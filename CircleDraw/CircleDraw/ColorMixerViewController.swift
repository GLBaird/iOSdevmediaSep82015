//
//  ColorMixerViewController.swift
//  CircleDraw
//
//  Created by Trainer on 09/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class ColorMixerViewController: UIViewController {
    
    // outlets
    @IBOutlet weak var sliderRed:UISlider!
    @IBOutlet weak var sliderGreen:UISlider!
    @IBOutlet weak var sliderBlue:UISlider!
    
    @IBOutlet weak var colorPreview:UIView!
    @IBOutlet weak var mixerNavItem: UINavigationItem!
    @IBOutlet weak var heighConstraint: NSLayoutConstraint!
    
    // property
    var mixedColor:UIColor!
    var delegate:ColorMixerViewControllerDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let color = mixedColor {
            var r:CGFloat = 0.0, g:CGFloat = 0.0, b:CGFloat = 0.0
            color.getRed(&r, green: &g, blue: &b, alpha: nil)
            sliderRed.value = Float(r)
            sliderGreen.value = Float(g)
            sliderBlue.value = Float(b)
            colorPreview?.backgroundColor = mixedColor
        }
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            mixerNavItem.rightBarButtonItem = nil
            heighConstraint.constant = 44.0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action methods
    
    @IBAction func sliderHasChanged(sender:UISlider) {
        mixedColor = UIColor(
            red: CGFloat(sliderRed.value),
            green: CGFloat(sliderGreen.value),
            blue: CGFloat(sliderBlue.value),
            alpha: 1.0
        )
        
        colorPreview?.backgroundColor = mixedColor
        delegate?.colorMixerHasChangedColor(mixer: self, newColor: mixedColor)
    }

}


protocol ColorMixerViewControllerDelegate {
    func colorMixerHasChangedColor(mixer mixer:ColorMixerViewController, newColor:UIColor)
}





