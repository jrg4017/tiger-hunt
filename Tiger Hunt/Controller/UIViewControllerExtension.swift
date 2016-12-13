//
//  UIViewControllerExtension.swift
//  Tiger Hunt
//
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

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
    
    // MARK: - LOGIN ALERT FUNC
    func loginAlert(title: String,  msg: String, textField: UITextField? ) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler:
            { action in if textField != nil { textField?.text = ""} }
        )
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - COMPLETED TASKS FUNCS
    func insertCompletedTask(task: Task) {
        var completedTasks = self.fetchCompletedTasks()
        let id = "\(task.getID())"
        
        //if key exists for whatever reason, remove it and update
        if let index = completedTasks.index(forKey: id) {
            completedTasks.remove(at: index)
        }
        
        completedTasks[id] = task.getCompletedImageURL()
        
        let taskData = NSKeyedArchiver.archivedData(withRootObject: completedTasks)
            
        let defaults = UserDefaults.standard
        defaults.set(taskData, forKey: "completedTasks")
        defaults.synchronize()
    }
    
    func fetchCompletedTasks() -> [String:String] {
        let taskData = UserDefaults.standard.object(forKey: "completedTasks") as? Data
        var completedTasks: [String:String] = [:]
        
        if let taskData = taskData {
            completedTasks = ((NSKeyedUnarchiver.unarchiveObject(with: taskData)) as! [String:String]!)
        }
        
        return completedTasks
    }
    
    func fetchTaskArray(_ allTasksArr: [Task]) -> [Task] {
        var completedTasks: [Task] = []
        let dictionary = fetchCompletedTasks()
        
        for t in allTasksArr {
            let id = "\(t.getID())"
            if (dictionary.index(forKey: id) != nil) {
                t.setCompletedImageURL(dictionary[id]!)
                completedTasks.append(t)
            }
        }
        
        return completedTasks
    }
    
    // MARK: - SWITCH ROOT CONTROLLER
    func switchRootController(storyboardName: String) {
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        appDelegate.window?.rootViewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()
        appDelegate.window?.makeKeyAndVisible()
    }
    
    // MARK: ANIMATION FUNCS
    func textFieldIsHidden(_ isHidden: Bool, _ textFieldArray: [UITextField]) {
        for textField in textFieldArray {
            textField.isHidden = isHidden
        }
    }
    
    func setButtonsHidden(_ isHidden: Bool, _ buttonArray: [UIButton]) {
        for button in buttonArray {
            button.isHidden = isHidden
        }
    }

    func slideView(_ uiViewItem: UIView, direction: String, delayStart: Double) {
        UIView.animate(withDuration: 1.0, delay: delayStart, options: [], animations: {
            (direction == "left") ? (uiViewItem.center.x -= self.view.bounds.width) : (uiViewItem.center.x += self.view.bounds.width)
            }, completion: nil)
    }
    
    // MARK: - WRITING AND LOADING USER
    func writeUID(_ uid: String) {
        let defaults = UserDefaults.standard
        defaults.setValue(uid, forKey: "uid")
        defaults.synchronize()
    }
    
    func loadUser(_ firUser: FIRUser, _ name: String) -> User {
        return User(
            uid: firUser.uid,
            name: name,
            email: firUser.email!,
            totalPoints: 0
        )
        
    }
}
