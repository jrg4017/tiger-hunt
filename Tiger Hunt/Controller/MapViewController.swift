//
//  MapViewController.swift
//  Tiger Hunt
//
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Foundation

/**
 * main controller for anything relating the app's mapview
 * extensions: MkMapViewDelegate, CLLocationManagerDelegate, UIPickerDelegate
 */
class MapViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var mapView: MKMapView!
    
    var taskList = Tasks()
    var tasks: [Task] {
        get {
            return self.taskList.taskList
        }
        set(val) {
            self.taskList.taskList = val
        }
    }

    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation:CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    // MARK: - Actions
    //zooms out to initial view
    @IBAction func zoomViewOut(_ sender: UIButton) {
        let lattitude = self.mapView.centerCoordinate.latitude
        let longitude = self.mapView.centerCoordinate.longitude
        
        zoomRegion(lattitude, longitude, Constants.ZOOMED_OUT_DELTA)
    }
    
    // MARK: - Lifecycle
    // on view did load, load annotations & location data
    // implement delegates for MKMapView, CLLocation, UIPickerView
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if tasks.count == 0 {
             let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            appDelegate.setViewControllerTaskLists()
        }
        
        self.loadLocation()
        self.loadAnnotations()
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        self.zoomRegion(Constants.RIT_LATTITUDE, Constants.RIT_LONGITUDE, Constants.ZOOMED_OUT_DELTA)
    }
    
    // MARK: - helper functions
    // MARK: zoom on MKMapView annotation
    //function to zoom in or out on a location
    func zoomRegion(_ lattitude: CLLocationDegrees, _ longitude: CLLocationDegrees, _ delta: Double) {
        let center = CLLocationCoordinate2D(latitude: lattitude, longitude: longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta))
        
        self.mapView.setRegion(region, animated: true)
    }
    
    //switches to map view and shows the annotation in question
    func showOnMap(_ task: Task) {
        self.tabBarController?.selectedIndex = Constants.MAP_VIEW_INDEX
        
        let lattitude = task.coordinate.latitude
        let longitude = task.coordinate.longitude
        
        zoomRegion(lattitude, longitude, Constants.ZOOMED_IN_DELTA)
    }
    
    // MARK: Loading Data
    //asks for location and sets up the need for location to update
    func loadLocation() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
    }
    
    //adds all tasks that aren't activities on the map
    // activites don't contain location coordinates
    func loadAnnotations() {
        for task in self.tasks {
            if !task.isActivity() {
                self.mapView.addAnnotation(task)
            }
        }
    }//end loadannotations
}
