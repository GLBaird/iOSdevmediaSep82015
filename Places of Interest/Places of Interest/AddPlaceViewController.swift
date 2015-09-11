//
//  AddPlaceViewController.swift
//  Places of Interest
//
//  Created by Trainer on 10/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class AddPlaceViewController: ToolbarViewController,
    UIActionSheetDelegate,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    CLLocationManagerDelegate
{

    // outlets
    @IBOutlet weak var placeNameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imagePreview: UIImageView!
    
    @IBOutlet var responders: [UIView]!
    
    // properties
    var location:CLLocation?
    lazy var locationManager = CLLocationManager()

    // MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup location services
        if CLLocationManager.locationServicesEnabled() {
            
            if #available(iOS 8.0, *) {
                locationManager.requestWhenInUseAuthorization()
            }
            
            locationManager.distanceFilter = 10
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            
            
        } else {
            ShowAlertWithTitle("Location Services Diabled",
                message: "Please allow locaton services as we use these for putting your places on a map",
                button: "Cancel",
                viewController: self
            )
            navigationController?.popViewControllerAnimated(true)
        }
        
        // listen for keyboard and add button
        NSNotificationCenter.defaultCenter()
            .addObserverForName(
                UIKeyboardWillShowNotification,
                object: nil,
                queue: nil,
                usingBlock: { (notice) in
                    let done = UIBarButtonItem(
                        barButtonSystemItem: UIBarButtonSystemItem.Done,
                        target: self,
                        action: "closeKeyboard:"
                    )
                    // User info about keyboard
                    print(notice.userInfo)
                    self.navigationItem.setRightBarButtonItem(done, animated: true)
            }
        )
        NSNotificationCenter.defaultCenter()
            .addObserverForName(
                UIKeyboardWillHideNotification,
                object: nil,
                queue: nil,
                usingBlock: { (notice) in
                    self.navigationItem.setRightBarButtonItem(nil, animated: true)
                }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Action methods
    
    @IBAction func save(sender: AnyObject) {
        func showMessage() {
            ShowAlertWithTitle("Please allow location services",
                message: "Without location services, this app won't work",
                button: "OK",
                viewController: self
            )
        }
        
        if #available(iOS 8.0, *) {
            if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse {
                showMessage()
                return
            }
        } else {
            if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.Authorized {
                showMessage()
                return
            }
        }
        
        // validate 
        if placeNameTextField.text!.isEmpty || descriptionTextView.text.isEmpty {
            ShowAlertWithTitle("Incomplete form",
                message: "You need to complete a name and description",
                button: "Cancel",
                viewController: self
            )
            return
        }
        
        // Make model and save
        var imagePath = ""
        let timeStamp = NSDate().timeIntervalSince1970
        if let image = pickedImage {
            imagePath = "/Documents/img-\(timeStamp).jpg"
            let filePath = NSHomeDirectory() + imagePath
            if let encodedImage = UIImageJPEGRepresentation(image, 1.0) {
                if !encodedImage.writeToFile(filePath, atomically: true) {
                    imagePath = ""
                }
            } else {
                imagePath = ""
            }
            
            if imagePath.isEmpty {
                ShowAlertWithTitle("Save Image Error",
                    message: "Failed to save your image",
                    button: "Cancel",
                    viewController: self
                )
                return
            }
        }
        
        let newPlace = NSEntityDescription.insertNewObjectForEntityForName(
            PlaceEntityName,
            inManagedObjectContext: AppDelegate.getContext()) as! Place
        
        newPlace.placeName = placeNameTextField.text
        newPlace.placeDescription = descriptionTextView.text
        newPlace.imagePath = imagePath
        newPlace.dateVisited = timeStamp
        if let location = self.location {
            newPlace.geoLat = location.coordinate.latitude
            newPlace.geoLong = location.coordinate.longitude
        }
        
        AppDelegate.getDelegate().saveContext()
        
        clear(self)
    }
    
    @IBAction func clear(sender: AnyObject) {
        for item in responders {
            if let textField = item as? UITextField {
                textField.text = ""
            } else if let textView = item as? UITextView {
                textView.text = ""
            }
            item.resignFirstResponder()
        }
        
        imagePreview.image = UIImage(named: "Plus")
        imagePreview.contentMode = UIViewContentMode.Center
        imagePreview.backgroundColor = UIColor.lightGrayColor()
        pickedImage = nil
    }

    @IBAction func pickImageSource() {
        if #available(iOS 8.0, *) {
            let choice = UIAlertController(
                title: "Pick Image",
                message: "Choose image source:",
                preferredStyle: .ActionSheet
            )
            
            if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                choice.addAction(
                    UIAlertAction(
                        title: "Camera",
                        style: .Default,
                        handler: { (action) -> Void in
                            self.showImagePicker(.Camera)
                    })
                )
            }
            
            choice.addAction(
                UIAlertAction(
                    title: "Photo Library",
                    style: .Default,
                    handler: { (action) -> Void in
                        self.showImagePicker(.PhotoLibrary)
                })
            )
            
            choice.addAction(
                UIAlertAction(
                    title: "Camera Roll",
                    style: .Default,
                    handler: { (action) -> Void in
                        self.showImagePicker(.SavedPhotosAlbum)
                })
            )
            
            choice.addAction(
                UIAlertAction(
                    title: "Cancel",
                    style: .Cancel,
                    handler: nil
                )
            )
            
            presentViewController(choice, animated: true, completion: nil)

        } else {
            // Fallback on earlier versions
            let choice = UIActionSheet(
                title: "Pick Image",
                delegate: self,
                cancelButtonTitle: "Cancel",
                destructiveButtonTitle: nil,
                otherButtonTitles: "Camera", "Photo Library", "Camera Roll"
            )
            choice.showInView(view)
        }
    }
    
    func showImagePicker(source:UIImagePickerControllerSourceType) {
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.allowsEditing = true
        picker.delegate = self
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func closeKeyboard(sender:UIBarButtonItem) {
        for item in responders {
            item.resignFirstResponder()
        }
    }
    
    // MARK: - UIActionSheet Delegate methods
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 0:
            if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                showImagePicker(.Camera)
            } else {
                showImagePicker(.PhotoLibrary)
            }
            
        case 1:
            showImagePicker(.PhotoLibrary)
            
        case 2:
            showImagePicker(.SavedPhotosAlbum)
        default:
            print("Choice cancelled")
        }
    }
    
    
    // MARK: - UIImagePickerController Delegate methods
    
    var pickedImage:UIImage?
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePreview.image = info[UIImagePickerControllerEditedImage] as? UIImage
        imagePreview.contentMode = UIViewContentMode.ScaleAspectFit
        imagePreview.backgroundColor = UIColor.clearColor()
        pickedImage = imagePreview.image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - CLLocationManager Delegate methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        print("Location found Lat: \(location?.coordinate.latitude) Long: \(location?.coordinate.longitude)")
    }
    
}
