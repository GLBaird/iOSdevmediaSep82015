//
//  PlacesTableViewController.swift
//  Places of Interest
//
//  Created by Trainer on 11/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit
import CoreData

class PlacesTableViewController: UITableViewController {
    
    var fetchedResults:NSFetchedResultsController! = {
        let request = NSFetchRequest(entityName: PlaceEntityName)
        request.sortDescriptors = [
            NSSortDescriptor(key: PlaceAttributeDate, ascending: true),
            NSSortDescriptor(key: PlaceAttributeName, ascending: true)
        ]
        
        return NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: AppDelegate.getContext(),
            sectionNameKeyPath: nil,
            cacheName: "Places"
        )
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get data from table
        do {
            try fetchedResults.performFetch()
        } catch {
            ShowAlertWithTitle(
                "Core Data Error",
                message: "Failed to load data",
                button: "OK",
                viewController: self
            )
            fetchedResults = nil
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if fetchedResults != nil {
            return fetchedResults.sections!.count
        }
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResults.sections![section].numberOfObjects
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PlaceTableViewCell
        let place = fetchedResults.objectAtIndexPath(indexPath) as! Place

        // Configure the cell...
        cell.placeNameLabel.text = place.placeName
        cell.placeDateLabel.text = place.shortDate
        if place.imagePath!.isEmpty {
            cell.placeImageView.image = nil
        } else {
            cell.placeImageView.image = UIImage(contentsOfFile: NSHomeDirectory()+place.imagePath!)
        }

        return cell
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let place = fetchedResults.objectAtIndexPath(indexPath) as! Place
            place.removeRelatedImage()
            AppDelegate.getContext().deleteObject(place)
            AppDelegate.getDelegate().saveContext()
            do {
                try fetchedResults.performFetch()
            } catch {}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Details" {
            let place = fetchedResults.objectAtIndexPath(tableView.indexPathForSelectedRow!) as! Place
            let detailVC = segue.destinationViewController as! DetailViewController
            detailVC.place = place
        }
    }
    

}
