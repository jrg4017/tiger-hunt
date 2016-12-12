//
//  UIViewControllerExtension.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/9/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

extension UIViewController {
    
    
    // MARK: - Custom border func
    func customBottomBorder(_ textField: UITextField) {
        let border = CALayer()
        let width = CGFloat(2.0)
        
        let colVal = CGFloat(187.0/255.0)
        let borderColor = UIColor(red: colVal, green: colVal, blue: colVal, alpha: 1.0)
        
        border.borderColor = borderColor.cgColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
        
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    
    func loginAlert(title: String,  msg: String, textField: UITextField ) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler:
            { action in textField.text = "" }
        )
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func insertCompletedTask(task: Task) {
        var completedTasks = fetchCompletedTasks()
        
        if !(completedTasks.contains(task.getTaskName())) {
            completedTasks.append(task.getTaskName())
            
            let taskData = NSKeyedArchiver.archivedData(withRootObject: completedTasks)
            
            let defaults = UserDefaults.standard
            defaults.set(taskData, forKey: "completedTasks")
            defaults.synchronize()
        }
    }
    
    func fetchCompletedTasks() -> [String] {
        let taskData = UserDefaults.standard.object(forKey: "completedTasks") as? Data
        var completedTasks: [String] = []
        
        if let taskData = taskData {
            completedTasks = (NSKeyedUnarchiver.unarchiveObject(with: taskData) as? [String])!
        }
        
        return completedTasks
    }
    
    func fetchTaskArray(_ allTasksArr: [Task]) -> [Task] {
        var completedTasks: [Task] = []
        let stringArr = fetchCompletedTasks()
        
        for t in stringArr {
            for ta in allTasksArr {
                if t == ta.getTaskName() {
                    completedTasks.append(ta)
                }
            }
        }
        
        return completedTasks
    }
    
    func switchRootController(storyboardName: String) {
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        appDelegate.window?.rootViewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()
        appDelegate.window?.makeKeyAndVisible()
    }
    
    func textFieldIsHidden(_ isHidden: Bool, _ textFieldArray: [UITextField]) {
        for textField in textFieldArray {
            textField.isHidden = isHidden
        }
    }

    func slideView(_ uiViewItem: UIView, direction: String, delayStart: Double) {
        UIView.animate(withDuration: 1.0, delay: delayStart, options: [], animations: {
            (direction == "left") ? (uiViewItem.center.x -= self.view.bounds.width) : (uiViewItem.center.x += self.view.bounds.width)
            }, completion: nil)
    }
}
