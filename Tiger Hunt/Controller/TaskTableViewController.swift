//
//  TaskTableViewController.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/10/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController {

    // MARK: - Properties
    var taskList = Tasks()
    var tempTasks: [Task] {
        get {
            return self.taskList.taskList
        }
        set(val) {
            self.taskList.taskList = val
        }
    }
    
    var completedTasks: [Task] = []
    var isCompletedTab: Bool = false

    var tasks: [Task] = []
    var activities: [Task] = []
    
    // MARK: - Constant properties
    let RIT_ORANGE: UIColor = UIColor(red: CGFloat(243.0/255.0), green: CGFloat(110.0/255.0), blue: CGFloat(33.0/255.0), alpha: 1.0)
    let NUM_OF_SECTIONS: Int = 2
    let TASK_LIST_TITLE: String = "PLACES"
    let ACTIVITY_TITLE: String = "ACTIVITIES (BONUS)"

    
    // MARK: - IBActions
    @IBAction func switchTaskList(_ sender: UISegmentedControl) {
        
        switch (sender.selectedSegmentIndex) {
            case 0:
                self.isCompletedTab = false
            case 1:
                self.isCompletedTab = true
            default:
                break;
        }
        
        self.completedTasks = fetchTaskArray(self.tempTasks)
        
        self.loadTasksActivites(self.isCompletedTab)
        self.tableView.reloadData()
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = self.RIT_ORANGE

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.completedTasks = fetchTaskArray(self.tempTasks)
        
        self.loadTasksActivites(self.isCompletedTab)
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDelegate functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.NUM_OF_SECTIONS
    }
    
    //return the number of cells to display total
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0 ) ? self.tasks.count : self.activities.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 && self.tasks.count > 0 {
            return self.TASK_LIST_TITLE
        }
        
        return (section == 1 && self.activities.count > 0) ? self.ACTIVITY_TITLE : nil
    }
    
    //display the text for the intial cell view, calls parent class

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var task: Task!
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskListCell") as! CustomTableViewCell
        
        switch indexPath.section {
            case 0:
                task = self.tasks[indexPath.row]
                cell.titleLabel.text = task.getTaskName()
            case 1:
                task = self.activities[indexPath.row]
                cell.titleLabel.text = task.getTaskName()
            default:
                break
        }
        
        let imageName = (self.completedTasks.index(of: task) != nil) ? "complete-task" : "incomplete-task"
        cell.taskImageView.image = UIImage(named: imageName)
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        let task = (indexPath.section == 0) ? self.tasks[indexPath.row] : self.activities[indexPath.row]
//        
//        let detailVC = TaskDetailViewController(style: .grouped)
//        detailVC.title =  task.getTaskName()
//
//        if (self.completedTasks.index(of: task) != nil) {
//            detailVC.isComplete = true
//            detailVC.title = task.getLocationName()
//        }
//        
////        navigationController?.performSegue(withIdentifier: "TaskDetailViewID", sender: self)
//        navigationController?.pushViewController(detailVC, animated: true)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if segue.identifier == "TaskDetailViewID" ,
        let nextScene = segue.destination as? TaskDetailViewController
        let indexPath = self.tableView.indexPathForSelectedRow
        
        let task = (indexPath?.section == 0) ? self.tasks[(indexPath?.row)!] : self.activities[(indexPath?.row)!]
        
        nextScene?.isComplete = (self.completedTasks.index(of: task) != nil) ? true : false
        nextScene?.task = task
        //}
    }
    
    func loadTasksActivites(_ isCompletedTab: Bool) {
        //reset to prevent duplicates
        self.tasks = []
        self.activities = []
        
        //load in the active list
        (self.isCompletedTab) ? self.loadCompleteActivities() : self.loadIncompleteActivities()
        
        //sort based on distance
        tasks = tasks.sorted { self.getDistance($0.coordinate) < self.getDistance($1.coordinate)}
    }
    
    func loadCompleteActivities() {
        for task in self.completedTasks {
            (!task.isActivity()) ? self.tasks.append(task) : self.activities.append(task)
        }
    }
    
    func loadIncompleteActivities() {
        for task in self.tempTasks {
            let index = self.completedTasks.index(of: task)
            
            if index == nil && !task.isActivity() {
                self.tasks.append(task)
            } else if index == nil {
                self.activities.append(task)
            }
        }
    }
    
}

