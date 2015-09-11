//
//  Place.swift
//  Places of Interest
//
//  Created by Trainer on 10/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import Foundation
import CoreData
import MapKit
import CoreLocation

let PlaceEntityName = "Place"
let PlaceAttributeName = "placeName"
let PlaceAttributeDate = "dateVisited"

class Place: NSManagedObject, MKAnnotation {

// Insert code here to add functionality to your managed object subclass
    
    var shortDate:String {
        return NSDateFormatter.localizedStringFromDate(
            NSDate(timeIntervalSince1970: dateVisited),
            dateStyle: NSDateFormatterStyle.ShortStyle,
            timeStyle: NSDateFormatterStyle.NoStyle
        )
    }
    
    var longDate:String {
        return NSDateFormatter.localizedStringFromDate(
            NSDate(timeIntervalSince1970: dateVisited),
            dateStyle: NSDateFormatterStyle.FullStyle,
            timeStyle: NSDateFormatterStyle.NoStyle
        )
    }
    
    func removeRelatedImage() {
        if imagePath != nil && imagePath != "" {
            let filepath = NSHomeDirectory() + imagePath!
            let fm = NSFileManager.defaultManager()
            if fm.fileExistsAtPath(filepath) {
                do {
                    try fm.removeItemAtPath(filepath)
                } catch { }
            }
        }
    }
    
    // MARK: - Map Annotations
    
    var coordinate:CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: geoLat, longitude: geoLong)
    }
    
    var title:String? {
        return placeName
    }
    
    var subtitle:String? {
        return "Visited on \(shortDate)"
    }
    

}
