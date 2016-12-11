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
            self.getDirections(view)
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
        
        zoomRegion(lattitude!, longitude!, self.ZOOMED_IN_DELTA)
        
    }
    
    //called for each annotation to create a pin
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // return nil to draw default blue dot
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView: MKAnnotationView?
        
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        //set custom view
        // TODO: set active and non active marker
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "tiger-marker-active")
        }
        
        return annotationView
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

        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        
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
