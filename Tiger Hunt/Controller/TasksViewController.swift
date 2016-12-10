//
//  TasksViewController.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/10/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

class TaskViewController: UITableViewController {
    
    // MARK: - Properties
    var taskList = Tasks()
    var tasks: [Task] {
        get {
            return self.taskList.taskList
        }
        set(val) {
            self.taskList.taskList = val
        }
    }
    
    
}
