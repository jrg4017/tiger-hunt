//
//  User.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/9/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    // MARK: - Properties
    private var name: String = ""
    private var email: String = ""
    private var username: String = ""
//    var dateJoined: Date
    
    override var description: String {
        return "{\n\tusername: \(self.username)\n\tname:\(self.name)\n\temail: \(self.email)\n}"
    }
    
    // MARK: - Initalizers
    init(name: String, email: String, username: String) {
        self.name = name
        self.email = email
        self.username = username
       // self.dateJoined = Date()
    }
    
    init(name: String, email: String, username: String, date: Date) {
        self.name = name
        self.email = email
        self.username = username
        //self.dateJoined = date
        
        super.init()
    }
    
    override convenience init() {
        self.init(name: "Unknown", email: "unknown@tigerhunt.com", username: "unknown")
    }
    
    // MARK: NSCoding Initializers
    required init(coder aDecoder: NSCoder) {
        self.username = aDecoder.decodeObject(forKey: "username") as! String
        self.name  = aDecoder.decodeObject(forKey: "name") as! String
        self.email = aDecoder.decodeObject(forKey: "email") as! String
        //self.dateJoined = aDecoder.decodeObject(forKey: "dateJoined") as! Date
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.username, forKey: "username")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.email, forKey: "email")
        //aCoder.encode(self.dateJoined, forKey: "dateJoined")
    }
    
    // MARK: - Mutators and Acessors
    func setName(_ name: String) { self.name = name }
    func getName() -> String { return self.name }
    func setUsername(_ username: String) { self.username = username }
    func getUsername() -> String { return self.username }
    func setEmail(_ email: String) { self.email = email }
    func getEmail() -> String { return self.email }
}
