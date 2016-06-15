//
//  MapController.swift
//  Scroll_of_Honor
//
//  Created by Matthew Lollis on 11/23/15.
//  Copyright © 2015 Garofalo. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Parse

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
   
   
   @IBOutlet weak var mapView: MKMapView!
   var locationManager: CLLocationManager!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      locationManager = CLLocationManager()
      locationManager.desiredAccuracy = kCLLocationAccuracyBest;
      locationManager.delegate = self;
      
      let status = CLLocationManager.authorizationStatus()
      if status == .NotDetermined || status == .Denied || status == .AuthorizedWhenInUse {
         // present an alert indicating location authorization required
         // and offer to take the user to Settings for the app via
         // UIApplication -openUrl: and UIApplicationOpenSettingsURLString
         locationManager.requestAlwaysAuthorization()
         locationManager.requestWhenInUseAuthorization()
      }
      locationManager.startUpdatingLocation()
      locationManager.startUpdatingHeading()
      
      
      
      //mapview setup to show user location
      mapView.delegate = self
      mapView.showsUserLocation = true
      mapView.mapType = MKMapType(rawValue: 2)!
      mapView.userTrackingMode = MKUserTrackingMode(rawValue: 2)!
      
      let scrollLocation = CLLocationCoordinate2DMake(34.67933743341727, -82.84175984603269)
      // Drop a pin
      let dropPin = MKPointAnnotation()
      dropPin.coordinate = scrollLocation
      dropPin.title = "Scroll of Honor"
      mapView.addAnnotation(dropPin)
      centerMapOnLocation(scrollLocation)
    
    
   
    
   }
   
   let regionRadius: CLLocationDistance = 1000
   func centerMapOnLocation(location: CLLocationCoordinate2D) {
      let coordinateRegion = MKCoordinateRegionMakeWithDistance(location,
         regionRadius * 2.0, regionRadius * 2.0)
      mapView.setRegion(coordinateRegion, animated: true)
   }
   
   func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation){
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
}