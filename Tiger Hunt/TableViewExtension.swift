//
//  TableViewExtension.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/10/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit
import CoreLocation

extension UITableViewController {
    //gets the distance in miles from the current location
    func getDistance(_ coordinates: CLLocationCoordinate2D) -> Double {
        let mapVC = self.tabBarController?.viewControllers?[0] as! MapViewController
        
        //convert to CLLocation from CLLocationCoordinate2Dß
        let currLocation = CLLocation(latitude: mapVC.currentLocation.latitude, longitude: mapVC.currentLocation.longitude)
        let parkLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        
        //calculate distance in miles (returns in meters)ß
        let distanceInMiles = currLocation.distance(from: parkLocation) / 1609.344
        
        //round to nearest 10th
        let multiplier = pow(10.0, 2.0)
        let roundedDistance = round(distanceInMiles * multiplier) / multiplier
        
        return roundedDistance
    }

}
