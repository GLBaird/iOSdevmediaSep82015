//
//  CircleView.swift
//  CircleDraw
//
//  Created by Trainer on 09/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: UIView {
    
    // properties
    var position:CGPoint!
    var diameter:CGFloat = UIDevice.currentDevice().userInterfaceIdiom == .Phone
        ? 100.0
        : 200.0
    
    @IBInspectable var color:UIColor = UIColor.blueColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    let shadowColor = UIColor.blackColor().CGColor
    
    var circleRect:CGRect {
        return CGRect(
            x: position.x - diameter/2.0,
            y: position.y - diameter/2.0,
            width: diameter,
            height: diameter
        )
    }

    override func drawRect(rect: CGRect) {
        // Drawing code
        if position == nil {
            position = CGPoint(x: bounds.width/2.0, y: bounds.height/2.0)
        }
        
        if let ctx = UIGraphicsGetCurrentContext() {
            // set fill and shadow
            color.setFill()
            CGContextSetShadowWithColor(ctx, CGSize(width: 3.0, height: 3.0), 5.0, shadowColor)
            CGContextFillEllipseInRect(ctx, circleRect)
        }
    }
    
    // MARK: - Responder methods
    
    var touchesBeingTracked:Set<UITouch> = []
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (touchesBeingTracked.count == 0 && touches.count <= 2)
            || (touchesBeingTracked.count == 1 && touches.count == 1) {
            touchesBeingTracked.unionInPlace(touches)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touchesBeingTracked.count == 1 {
            // move
            position = touches.first?.locationInView(self)
        } else {
            // get touch data
            let allTouches = Array<UITouch>(touchesBeingTracked)
            let fPos1 = allTouches[0].locationInView(self)
            let fPos2 = allTouches[1].locationInView(self)
            
            // calc pinch
            let diffX = fPos1.x - fPos2.x
            let diffY = fPos1.y - fPos2.y
            
            // size and position
            diameter = sqrt(diffX*diffX + diffY*diffY)
            position.x = fPos1.x - diffX/2.0
            position.y = fPos1.y - diffY/2.0
        }
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchesBeingTracked.subtractInPlace(touches)
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        if touches != nil {
            touchesEnded(touches!, withEvent: event)
        }
    }


}
