//
//  User.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/9/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import Foundation

class User {
    // MARK: - Properties
    private var name: String = ""
    private var email: String = ""
    private var totalPoints: Int = 0
    private var dateJoined: Date
    
    // MARK: - Initalizers
    init(name: String, email: String, totalPoints: Int) {
        self.name = name
        self.email = email
        self.totalPoints = totalPoints
        self.dateJoined = Date()
    }
    
    init(name: String, email: String, totalPoints: Int, date: Date) {
        self.name = name
        self.email = email
        self.totalPoints = totalPoints
        self.dateJoined = date
    }
    
    convenience init() {
        self.init(name: "Unknown", email: "unknown@tigerhunt.com", totalPoints: 0)
    }

    // MARK: - Mutators and Acessors
    func setName(_ name: String) { self.name = name }
    func getName() -> String { return self.name }
    func setEmail(_ email: String) { self.email = email }
    func getEmail() -> String { return self.email }
    func getDateJoined() -> Date { return self.dateJoined }
    func setTotalPoints(_ totalPoints: Int) { self.totalPoints = totalPoints }
    func getTotalPoints() -> Int { return self.totalPoints }

}
//
//class User: NSObject, NSCoding {
//    // MARK: - Properties
//    private var name: String = ""
//    private var email: String = ""
//    //private var totalPoints: Int = 0
//    //private var dateJoined: Date
//    
//    override var description: String {
//        return "{\n\tname:\(self.name)\n\temail: \(self.email)\n}"
//    }
//    
//    // MARK: - Initalizers
//    init(name: String, email: String, totalPoints: Int) {
//        self.name = name
//        self.email = email
//       // self.totalPoints = totalPoints
//        //self.dateJoined = Date()
//    }
//    
//    init(name: String, email: String, totalPoints: Int, date: Date) {
//        self.name = name
//        self.email = email
//        //self.totalPoints = totalPoints
//        //self.dateJoined = date
//        
//        super.init()
//    }
//    
//    override convenience init() {
//        self.init(name: "Unknown", email: "unknown@tigerhunt.com", totalPoints: 0)
//    }
//    
//    // MARK: NSCoding Initializers
//    required init(coder aDecoder: NSCoder) {
//        self.name  = aDecoder.decodeObject(forKey: "name") as! String
//        self.email = aDecoder.decodeObject(forKey: "email") as! String
//       // self.totalPoints = Int((aDecoder.decodeObject(forKey: "totalPoints") as! NSString).intValue)
//        
//        //self.dateJoined = (aDecoder.decodeObject(forKey: "dateJoined") as! NSString) as Date
//        
//        super.init()
//    }
//    
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(self.name, forKey: "name")
//        aCoder.encode(self.email, forKey: "email")
//        //aCoder.encode(self.totalPoints, forKey: "totalPoints")
//        //aCoder.encode(self.dateJoined, forKey: "dateJoined")
//    }
//    
//    // MARK: - Mutators and Acessors
//    func setName(_ name: String) { self.name = name }
//    func getName() -> String { return self.name }
//    func setEmail(_ email: String) { self.email = email }
//    func getEmail() -> String { return self.email }
//    //func getDateJoined() -> Date { return self.dateJoined }
////    func setTotalPoints(_ totalPoints: Int) { self.totalPoints = totalPoints }
////    func getTotalPoints() -> Int { return self.totalPoints }
//}
