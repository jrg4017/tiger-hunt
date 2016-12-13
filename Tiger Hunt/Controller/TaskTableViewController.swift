//
//  TaskTableViewController.swift
//  Tiger Hunt
//
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit
import FirebaseAuth

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
    var user: User = User()
    
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
        loadUser()
        self.navigationController?.navigationBar.barTintColor = Constants.RIT_ORANGE
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.completedTasks = fetchTaskArray(self.tempTasks)
        
        self.loadTasksActivites(self.isCompletedTab)
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDelegate functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.NUM_OF_SECTIONS
    }
    
    //return the number of cells to display total
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0 ) ? self.tasks.count : self.activities.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 && self.tasks.count > 0 {
            return Constants.TASK_LIST_TITLE
        }
        
        return (section == 1 && self.activities.count > 0) ? Constants.ACTIVITY_TITLE : nil
    }
    
    //display the text for the intial cell view, calls parent class

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var task: Task!
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskListCell") as! CustomTableViewCell
        
        switch indexPath.section {
            case 0:
                task = self.tasks[indexPath.row]
                cell.titleLabel.text = (self.completedTasks.index(of: task) == nil) ? task.getTaskName() : task.getLocationName()
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
    
    // MARK: - PREPARE SEQUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextScene = segue.destination as? TaskDetailViewController
        let indexPath = self.tableView.indexPathForSelectedRow
        
        let task = (indexPath?.section == 0) ? self.tasks[(indexPath?.row)!] : self.activities[(indexPath?.row)!]
        
        nextScene?.isComplete = (self.completedTasks.index(of: task) != nil) ? true : false
        nextScene?.task = task
        nextScene?.user = self.user
    }
    
    // MARK: - HELPER FUNC
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
    
    func loadUser() {
        let firUser: FIRUser = (FIRAuth.auth()?.currentUser)!
        
        DataService.dataService.USERS_REF.child(firUser.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? ""
            let totalPoints = value?["totalPoints"] as? Int ?? 0
            
            self.user = User(
                uid: firUser.uid,
                name: name,
                email: firUser.email!,
                totalPoints: totalPoints
            )
            
        }) { (error) in
            print(error.localizedDescription)
        }

    }
}

