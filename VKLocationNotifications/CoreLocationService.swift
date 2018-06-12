//
//  CoreLocationService.swift
//  VKLocationNotifications
//
//  Created by Vamshi Krishna on 26/05/18.
//  Copyright © 2018 Vamshi Krishna. All rights reserved.
//

import Foundation
import CoreLocation

class CoreLocationService : NSObject, CLLocationManagerDelegate{
    private override init(){}
    static let sharedInstance = CoreLocationService()
    
    var shouldSetRegion = true
    let locationManager = CLLocationManager()
    
    func authorizeUser(){
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
    }
    
    func updateLocation(){
        shouldSetRegion = true
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Updated user's location")
        guard let currentLocation = locations.first, shouldSetRegion else { return }
        shouldSetRegion = false
        let region = CLCircularRegion(center: currentLocation.coordinate, radius: 20, identifier: "startPosition")
        manager.startMonitoring(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Did detect specified location")
        NotificationCenter.default.post(name: NSNotification.Name("internalNotification.enteredRegion"),
                                        object: nil)
    }
    
}
