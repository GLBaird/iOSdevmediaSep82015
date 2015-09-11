//
//  PlaceTableViewCell.swift
//  Places of Interest
//
//  Created by Trainer on 11/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    
    // outlets
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeDateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
