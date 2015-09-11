//
//  ToolbarViewController.swift
//  Places of Interest
//
//  Created by Trainer on 10/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class ToolbarViewController: UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setToolbarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController?.setToolbarHidden(true, animated: true)
    }

}
