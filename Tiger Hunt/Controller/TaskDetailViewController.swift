//
//  TaskDetailViewController.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/10/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    // MARK: - Properties
    var task: Task!
    var isComplete: Bool = false

    @IBOutlet weak var taskImageView: UIImageView!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var showOnMapButton: UIButton!
    @IBOutlet weak var submitPhotoButton: UIButton!
    
    @IBAction func submitPhoto(_ sender: UIButton) {
        //todo add photo functionality
        self.insertCompletedTask(task: self.task)
        self.isComplete = true
        sender.isHidden = true
        //todo adjust layout when .removeSuperView() is called
    }
    
    @IBAction func showOnMap(_ sender: UIButton) {
        let mapVC = tabBarController?.viewControllers?[0] as! MapViewController
        mapVC.showOnMap(self.task)
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //allows the section to have variable heights, to adapt to content
        self.pointsLabel.text = "\(self.task.getPoints()) points"
        
        // todo: resize label according to length
        self.hintLabel.text = self.task.getHint()
        self.hintLabel.numberOfLines = 0
        self.hintLabel.sizeToFit()
        
        self.submitPhotoButton.isHidden = self.isComplete
        self.showOnMapButton.isHidden = self.task.isActivity()
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = (self.isComplete) ? self.task.getLocationName() : self.task.getTaskName()
    }
    
}
