//
//  User.swift
//  Tiger Hunt
//
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    // MARK: - Properties
    private var uid: String = ""
    private var name: String = ""
    private var email: String = ""
    private var totalPoints: Int = 0
    override var description: String {
        return "{\n\tname:\(self.name)\n\temail: \(self.email)\n}"
    }
    
    // MARK: - Initalizers
    init(uid: String, name: String, email: String, totalPoints: Int) {
        self.uid = uid
        self.name = name
        self.email = email
        self.totalPoints = totalPoints
        super.init()
    }
    
    override convenience init() {
        self.init(uid: "0", name: "Unknown", email: "unknown@tigerhunt.com", totalPoints: 0)
    }
    
    // MARK: NSCoding Initializers
    required init(coder aDecoder: NSCoder) {
        self.uid  = aDecoder.decodeObject(forKey: "uid") as! String
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.uid, forKey: "uid")
    }

    // MARK: - Mutators and Acessors
    func getUID() -> String { return self.uid }
    func setName(_ name: String) { self.name = name }
    func getName() -> String { return self.name }
    func setEmail(_ email: String) { self.email = email }
    func getEmail() -> String { return self.email }
    func setTotalPoints(_ totalPoints: Int) { self.totalPoints = totalPoints }
    func getTotalPoints() -> Int { return self.totalPoints }

}
