//
//  AppDelegate.swift
//  Tiger Hunt
//
//  Created by student on 12/6/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var loginSession: String = ""
    var user: User?
    var tasks: [Task] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
  
        //load in the user and task data
        self.loadTasks()
        
        //if the user isn't logged in set the rootcontroller the Login storyboard
        if !isUserLoggedIn() {
            self.window?.rootViewController = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()
        } else {
            self.setViewControllerTaskLists()
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
    
    func loadTasks() {
        if let path = Bundle.main.path(forResource: "tasks", ofType: "plist") {
            let tempDict = NSDictionary(contentsOfFile: path)
            let tempArray = (tempDict?.value(forKey: "tasks") as! NSArray) as Array
            
            for dict in tempArray {
                var t: Task = Task()
                
                let taskName = dict["taskName"]! as! String
                let locationName = dict["locationName"] as! String
                let points = (dict["points"]! as! NSString).integerValue
                let hint = dict["hint"]! as! String
                let isActivity = (dict["isActivity"]! as! NSString).boolValue
                
                //if it is not an activity, it's an mkannotation/pin
                if !isActivity {
                    let latitude = (dict["latitude"]! as! NSString).doubleValue
                    let longitude = (dict["longitude"]! as! NSString).doubleValue
                    let location = CLLocation(latitude: latitude, longitude: longitude)
                
                    t = Task(taskName: taskName, locationName: locationName, points: points, hint: hint, location: location)
                } else {
                    t = Task(taskName: taskName, locationName: locationName, points: points, hint: hint)
                }
                
                tasks.append(t)
            }
        }
    }
    
    func setViewControllerTaskLists() {
        let tabBarController = self.window?.rootViewController as? UITabBarController
        let mapVC = tabBarController!.viewControllers![0] as! MapViewController
        
        let navVC = tabBarController!.viewControllers![1] as! UINavigationController
        let taskVC = navVC.viewControllers[0] as! TaskTableViewController
        
        let nav2VC = tabBarController!.viewControllers?[3] as! UINavigationController
        let profileVC = nav2VC.viewControllers[0] as! ProfileViewController
        profileVC.user = self.user
        
        let taskList = Tasks()
        taskList.taskList = tasks
        mapVC.taskList = taskList
        taskVC.taskList = taskList
    }

    func isUserLoggedIn() -> Bool {
        //let preferences = UserDefaults.standard
        //if preferences.object(forKey: "session") != nil {
            //loginSession = preferences.object(forKey: "session") as! String
            //check_session()
            //return true
        //}
            let userData = UserDefaults.standard.object(forKey: "user") as? Data
            
            if let userData = userData {
                user = (NSKeyedUnarchiver.unarchiveObject(with: userData) as? User)!
                return true
            }
        
        return false
    }
    
    func switchRootController() {
        self.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        
        self.loadTasks()
        self.setViewControllerTaskLists()
        
        self.window?.makeKeyAndVisible()
    }
    
    //TODO: grab user info 
    
}

