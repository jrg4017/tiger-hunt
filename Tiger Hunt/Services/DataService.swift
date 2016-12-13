//
//  DataService.swift
//  Tiger Hunt
//
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

class DataService {
    //MARK: - STATIC SELF
    static let dataService = DataService()
    
    //MARK: - PROPERTIES
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
    
    // MARK: - DATABASE FUNC
    func persistUser(_ user: User) {
        let dict: NSDictionary = [
            "name": user.getName(),
            "email": user.getEmail(),
            "totalPoints": user.getTotalPoints()
        ]

        self.USERS_REF.child(user.getUID()).setValue(dict)
    }
    
    func removeUser(_ uid: String) {
        USERS_REF.child(uid).removeValue()
    }
}
