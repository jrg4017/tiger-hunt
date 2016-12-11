//
//  CustomTaskDetailCell.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/10/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

class CustomTaskDetailCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var submittedImageView: UIImageView!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var viewOnMapButton: UIButton!
    @IBOutlet weak var submitPhotoButton: UIButton!
    @IBOutlet weak var pointsLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
