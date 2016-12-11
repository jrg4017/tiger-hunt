//
//  TaskDetailViewController.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/10/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

//class TaskDetailViewController: UITableViewController {
//    
//    // MARK: - Properties
//    var task: Task!
//    var isComplete: Bool = false
//    
//    
//    
//    // MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //self.viewOnMapButton.isHidden = self.task.isActivity()
//      
//        self.navigationController?.navigationBar.tintColor = .white
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        self.submitPhotoButton.isHidden = (self.isComplete) ? true : false
//        
//        //self.title.text = (self.isComplete) ? self.task.getLocationName() : self.task.getTaskName()
//    }
//}
//
class TaskDetailViewController: UIViewController {
    
    // MARK: - Properties
    var task: Task?
    var isComplete: Bool = false

    @IBOutlet weak var taskImageView: UIImageView!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var showOnMapButton: UIButton!
    @IBOutlet weak var submitPhotoButton: UIButton!
    
//    @IBAction func submitPhoto(_ sender: UIButton) {
//        //todo add photo functionality
//        self.isComplete = true
//        sender.isHidden = true
//    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(task)
        
        //allows the section to have variable heights, to adapt to content
        //self.pointsLabel?.text = "\(self.task.getPoints())"
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
}
