//
//  AppDelegate.swift
//  Tiger Hunt
//
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - PROPERTIES
    var window: UIWindow?
    var loginSession: String = ""
    var user: User?
    var tasks: [Task] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()
        FIRDatabase.database().persistenceEnabled = true
        
        //load in the user and task data
        self.loadTasks()
        self.setViewControllerTaskLists()
        
        //if the user isn't logged in set the rootcontroller the Login storyboard
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user == nil {
                self.window?.rootViewController = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()
            } 
        }

        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    // MARK: - HELPER FUNC
    func loadTasks() {
        if let path = Bundle.main.path(forResource: "tasks", ofType: "plist") {
            let tempDict = NSDictionary(contentsOfFile: path)
            let tempArray = (tempDict?.value(forKey: "tasks") as! NSArray) as Array
            
            for dict in tempArray {
                var t: Task = Task()
                
                let id = (dict["taskID"] as! NSString).integerValue
                let taskName = dict["taskName"]! as! String
                let locationName = dict["locationName"] as! String
                let points = (dict["points"]! as! NSString).integerValue
                let hint = dict["hint"]! as! String
                let isActivity = (dict["isActivity"]! as! NSString).boolValue
                let imageURL = dict["imageURL"] as! String
                
                //if it is not an activity, it's an mkannotation/pin
                if !isActivity {
                    let latitude = (dict["latitude"]! as! NSString).doubleValue
                    let longitude = (dict["longitude"]! as! NSString).doubleValue
                    let location = CLLocation(latitude: latitude, longitude: longitude)
                
                    t = Task(id: id, taskName: taskName, locationName: locationName, points: points, hint: hint, imageURL: imageURL, location: location)
                } else {
                    t = Task(id: id, taskName: taskName, locationName: locationName, points: points, hint: hint, imageURL: imageURL)
                }
                
                tasks.append(t)
            }
        }
    }
    
    //called when switching back to main storyboard
    func setViewControllerTaskLists() {
        let tabBarController = self.window?.rootViewController as? UITabBarController
        let mapVC = tabBarController!.viewControllers![0] as! MapViewController
        
        let navVC = tabBarController!.viewControllers![1] as! UINavigationController
        let taskVC = navVC.viewControllers[0] as! TaskTableViewController
        
        let taskList = Tasks()
        taskList.taskList = tasks
        mapVC.taskList = taskList
        taskVC.taskList = taskList
    }
}

