//
//  MkMapViewDelegate.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/9/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit
import MapKit
import AddressBook

/**
 * extension handles the needs for MKMapViewDelegate
 * see MapViewController
 */
extension MapViewController: MKMapViewDelegate {
    
    // MARK: - MKMapViewDelegate functions
    
    //button right and left clicks
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if (control == view.rightCalloutAccessoryView) {
            getDirections(view)
        }
//        else if (control == view.leftCalloutAccessoryView) {
//            goToWebsite(view)
//        }
    }
    
    //zoom on selected annotation
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation
        
        let lattitude = annotation?.coordinate.latitude
        let longitude = annotation?.coordinate.longitude
        
        zoomRegion(lattitude!, longitude!, ZOOMED_IN_DELTA)
        
    }
    
    //called for each annotation to create a pin
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var view:MKPinAnnotationView
        let identifier = "Pin"
        
        if annotation is MKUserLocation {
            // Return nil so it will draw the default view -- i.e. blue dot
            return nil
        } // end of annotation is
        
        if annotation !== mapView.userLocation {
            
            // look for an existing view to use
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
                
            } else {
                
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.pinTintColor = MKPinAnnotationView.greenPinColor()
                view.animatesDrop = true
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: -5)
                let leftButton = UIButton(type: .infoLight)
                
                let rightButton = UIButton(type: .detailDisclosure)
                rightButton.setImage(UIImage(named: "navigate.png"), for: .normal)
                
                leftButton.tag = 0
                rightButton.tag = 1
                view.leftCalloutAccessoryView = leftButton
                view.rightCalloutAccessoryView = rightButton
            }
            return view
        }
        return nil
    }
    
    // MARK: - helper functions for MKMapViewDelegate
    //gets directions by going maps navigation
    func getDirections(_ view: MKAnnotationView) {
        let destination = view.annotation
        
        let currentLocMapItem = MKMapItem.forCurrentLocation()
        
        let destinationPlacemark = MKPlacemark(coordinate: (destination?.coordinate)!, addressDictionary: nil)
        
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        destinationMapItem.name = destination?.title!
        
        let mapItems = [currentLocMapItem, destinationMapItem]
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        
        MKMapItem.openMaps(with: mapItems, launchOptions:launchOptions)
    }
    
//    //goes to the task's website
//    func goToWebsite(_ view: MKAnnotationView) {
//        let annotation = view.annotation
//        
//        for task in tasks {
//            if task.title == annotation?.title! {
//                let taskURL = NSURL(string: task.getLink())! as URL
//                UIApplication.shared.open(taskURL, options: [:], completionHandler: nil)
//            }
//        }
//    } //end goToWebsite
}
