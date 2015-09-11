//
//  Place+CoreDataProperties.swift
//  Places of Interest
//
//  Created by Trainer on 10/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Place {

    @NSManaged var placeName: String?
    @NSManaged var dateVisited: NSTimeInterval
    @NSManaged var placeDescription: String?
    @NSManaged var imagePath: String?
    @NSManaged var geoLat: Double
    @NSManaged var geoLong: Double

}
