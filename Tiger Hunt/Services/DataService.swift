//
//  DataService.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/12/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

class DataService {
    static let dataService = DataService()
    
    private var _BASE_REF = FIRDatabase.database().reference(fromURL: Constants.FIR_BASE_URL)
    
    var REF: FIRDatabaseReference {
        return _BASE_REF
    }
    
    var USERS_REF: FIRDatabaseReference {
        return _BASE_REF.child("users")
    }
    
    var TASKS_REF: FIRDatabaseReference {
        return _BASE_REF.child("tasks")

    }
    
    var COMPLETED_TASKS_REF: FIRDatabaseReference {
        return _BASE_REF.child("completedTasks")
    }
    
    func persistUser(_ user: User) {
        let dict: NSDictionary = [
            "name": user.getName(),
            "email": user.getEmail(),
            "totalPoints": user.getTotalPoints()
        ]

        self.USERS_REF.child(user.getUID()).setValue(dict)
    }
    
    func updateTaskList(uid: String, _ newTask: Task) {
        COMPLETED_TASKS_REF.child(uid).child("tasks").observe(.value, with: { (snapshot) in
            // Get user value
            var completedTasks = snapshot.value as! [String]
            completedTasks.append(("\(newTask.getID())"))
            self.COMPLETED_TASKS_REF.child(uid).child("tasks").child(uid).setValue(completedTasks as NSArray)
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }
    
    func removeUser(_ user: User) {
        USERS_REF.child(user.getUID()).removeValue()
    }
}
