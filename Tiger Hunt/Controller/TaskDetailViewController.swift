//
//  TaskDetailViewController.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/10/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

class TaskDetailViewController: UITableViewController {
    
    // MARK: - Properties
    var task: Task!
    var isComplete: Bool = false
    
    // MARK: Constants
    let SECTION_0_ROWS: Int = 2
    let NUM_OF_SECTIONS: Int = 3
    let ACTIVITY_NUM_OF_SECTIONS: Int = 2
    let NUM_OF_ROWS: Int = 1
    let STANDARD_ROW_HEIGHT: CGFloat = 50.0
    let MAP_CELL_TITLE: String = "Show on Map"
    let PHOTO_CELL_TITLE: String = "Submit a photo"
    let PHOTO_SUBMITTED_TITLE: String = "You've completed this task!"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //allows the section to have variable heights, to adapt to content
        super.tableView.rowHeight = UITableViewAutomaticDimension
        super.tableView.estimatedRowHeight = self.STANDARD_ROW_HEIGHT
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    
    // MARK: - UITableViewDelegate functions
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return (self.task.isActivity()) ? self.ACTIVITY_NUM_OF_SECTIONS : self.NUM_OF_SECTIONS
    }
    
    //returns the number of rows in a section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? self.SECTION_0_ROWS : self.NUM_OF_ROWS
    }


    //when tapping on specific sections, implement appropiate action
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
            case 1:
                (self.isComplete) ? print("complete") : print("submit task photo")
            case 2:
                if !self.task.isActivity() {
                    let mapVC = tabBarController?.viewControllers?[0] as! MapViewController
                    mapVC.showOnMap(self.task)
                }
            default:
                break
        }
    
        //deselect the row that was clicked
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //sets the content for each section
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
        }
        
        switch indexPath.section {
            case 0:
                self.setSection0Content(cell!, indexPath)
            case 1:
                cell!.textLabel?.text = (self.isComplete) ? self.PHOTO_SUBMITTED_TITLE : self.PHOTO_CELL_TITLE
            case 2:
                cell!.textLabel?.text = (self.task.isActivity()) ? "" : self.MAP_CELL_TITLE
            default:
                break
        }
        
        if indexPath.section != 0 {
            cell!.textLabel?.textAlignment = .center
        }
        
        cell?.textLabel?.numberOfLines = 0 // use as many lines as it needs
        
        return cell!
    }
    
    func setSection0Content(_ cell: UITableViewCell, _ indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
                cell.textLabel?.text = "\(self.task.getHint())"
            case 1:
                cell.textLabel?.text = "\(self.task.getPoints()) points"
                cell.textLabel?.textAlignment = .center
            default:
                break
        }
        
    }

}
//
//class TaskDetailViewController: UITableViewController {
//    
//    // MARK: - Properties
//    var task: Task!
//    var isComplete: Bool = false
//    
//    // MARK: Constants
//    let SECTION_0_ROWS: Int = 2
//    let NUM_OF_SECTIONS: Int = 3
//    let ACTIVITY_NUM_OF_SECTIONS: Int = 2
//    let NUM_OF_ROWS: Int = 1
//    let STANDARD_ROW_HEIGHT: CGFloat = 50.0
//    let MAP_CELL_TITLE: String = "Show on Map"
//    let PHOTO_CELL_TITLE: String = "Submit a photo"
//    let PHOTO_SUBMITTED_TITLE: String = "You've completed this task!"
//    
//    // MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //allows the section to have variable heights, to adapt to content
//        super.tableView.rowHeight = UITableViewAutomaticDimension
//        super.tableView.estimatedRowHeight = self.STANDARD_ROW_HEIGHT
//        
//        navigationController?.navigationBar.tintColor = .white
//        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
//    }
//    
//    
//    // MARK: - UITableViewDelegate functions
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return (self.task.isActivity()) ? self.ACTIVITY_NUM_OF_SECTIONS : self.NUM_OF_SECTIONS
//    }
//    
//    //returns the number of rows in a section
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return (section == 0) ? self.SECTION_0_ROWS : self.NUM_OF_ROWS
//    }
//    
//    
//    //when tapping on specific sections, implement appropiate action
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.section {
//        case 1:
//            (self.isComplete) ? print("complete") : print("submit task photo")
//        case 2:
//            if !self.task.isActivity() {
//                let mapVC = tabBarController?.viewControllers?[0] as! MapViewController
//                mapVC.showOnMap(self.task)
//            }
//        default:
//            break
//        }
//        
//        //deselect the row that was clicked
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//    
//    //sets the content for each section
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
//        
//        if (cell == nil) {
//            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
//        }
//        
//        switch indexPath.section {
//        case 0:
//            self.setSection0Content(cell!, indexPath)
//        case 1:
//            cell!.textLabel?.text = (self.isComplete) ? self.PHOTO_SUBMITTED_TITLE : self.PHOTO_CELL_TITLE
//        case 2:
//            cell!.textLabel?.text = (self.task.isActivity()) ? "" : self.MAP_CELL_TITLE
//        default:
//            break
//        }
//        
//        if indexPath.section != 0 {
//            cell!.textLabel?.textAlignment = .center
//        }
//        
//        cell?.textLabel?.numberOfLines = 0 // use as many lines as it needs
//        
//        return cell!
//    }
//    
//    func setSection0Content(_ cell: UITableViewCell, _ indexPath: IndexPath) {
//        switch indexPath.row {
//        case 0:
//            cell.textLabel?.text = "\(self.task.getHint())"
//        case 1:
//            cell.textLabel?.text = "\(self.task.getPoints()) points"
//            cell.textLabel?.textAlignment = .center
//        default:
//            break
//        }
//        
//    }
//    
//}
