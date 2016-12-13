//
//  CLLocationManagerDelegate.swift
//  Tiger Hunt
//
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import CoreLocation

extension MapViewController: CLLocationManagerDelegate {
    // MARK: - CLLocationManagerDelegate functions
    //updates current location, used by other controllers
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = manager.location!.coordinate
    }

}
