//
//  Task.swift
//  Tiger Hunt
//
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Task: NSObject, NSCoding, MKAnnotation {
    
    // MARK: - Properties
    private var id: Int
    private var taskName: String = ""
    private var locationName: String = ""
    private var points: Int = 0
    private var hint: String = ""
    private var location: CLLocation?
    private var isActivityTask: Bool = false
    private var completedImageURL: String = ""
    
    // MARK: MkAnnotation properties
    @objc var coordinate: CLLocationCoordinate2D {
        get {
            return self.location!.coordinate
        }
    }
    
    @objc var title: String? {
        get {
            return self.taskName
        }
    }
    
    @objc var subtitle: String? {
        get {
            return "\(self.points) points"
        }
    }
    
    // MARK: NSObject property override
    override var description : String {
        return "{\n\tid: \(self.id)\n\tlocationName: \(self.locationName)\n\tttaskName: \(self.taskName)\n\tpoints: \(self.points)\n\thint: \(self.hint)\n\tlocation: \(self.location!)\n\t isActivity: \(self.isActivityTask)\n}"
    }
    
    // MARK: - Initializers
    init(id: Int, taskName: String, locationName: String, points: Int, hint: String, imageURL: String, location: CLLocation?) {
        self.id = id
        self.taskName = taskName
        self.locationName = locationName
        self.points = points
        self.hint = hint
        self.location = location
        self.completedImageURL = imageURL
        
        super.init()
    }
    
    init(id: Int, taskName: String, locationName: String, points: Int, hint: String, imageURL: String) {
        self.id = id
        self.taskName = taskName
        self.locationName = locationName
        self.points = points
        self.hint = hint
        self.location = nil
        self.isActivityTask = true
        self.completedImageURL = imageURL
        
        super.init()
    }
    
    override convenience init() {
        self.init(id: 0, taskName: "Unknown", locationName: "Unknown", points: 0, hint: "No idea where this is", imageURL: "",location: nil)
    }
    
    convenience init(isActivity: Bool) {
        self.init(id: 0, taskName: "Unknown", locationName: "Unknown", points: 0, hint: "No idea where this is", imageURL: "")
    }
    
    // MARK: NSCoding intializers
    required init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "taskId") as! Int
        self.completedImageURL = aDecoder.decodeObject(forKey: "imageURL") as! String
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "taskId")
        aCoder.encode(self.completedImageURL, forKey: "imageURL")
    }
    
    // MARK: - Mutators and Accessors
    func getID() -> Int { return self.id }
    func setLocationName(_ locationName: String) { self.locationName = locationName }
    func getLocationName() -> String? { return self.locationName }
    func setTaskName(_ taskName: String) { self.taskName = taskName }
    func getTaskName() -> String { return self.taskName }
    func setPoints(_ points: Int) { self.points = points }
    func getPoints() -> Int { return self.points }
    func setHint(_ hint: String) { self.hint = hint }
    func getHint() -> String { return self.hint }
    func setIsActivity(_ isActivityTask: Bool) { self.isActivityTask = isActivityTask }
    func isActivity() -> Bool { return self.isActivityTask }
    func setCompletedImageURL(_ imageLink: String) { self.completedImageURL = imageLink }
    func getCompletedImageURL() -> String { return self.completedImageURL }
}
