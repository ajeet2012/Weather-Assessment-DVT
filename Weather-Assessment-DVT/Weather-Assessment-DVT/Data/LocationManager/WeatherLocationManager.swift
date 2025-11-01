//
//  WeatherLocationManager.swift
//  Weather-Assessment-DVT
//
//  Created by Ajeet Sharma on 02/11/2025.
//

import Foundation
import CoreLocation

final class WeatherLocationManager:NSObject, ObservableObject{
    
    private let locationManager = CLLocationManager()
    @Published var currentLocation: CLLocation?
    @Published var locationError: Error?
    @Published var city: String = ""
    @Published var country: String = ""
    
    override init() {
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
    }
    
    func requestForLocation() {
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let status = self.locationManager.authorizationStatus
        
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.requestLocation()
        }
        else {
            self.locationError = NSError(domain: "Location", code: 1, userInfo: [NSLocalizedDescriptionKey : "Location permission denied"])
        }
    }
}

extension WeatherLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        currentLocation = location
        
        
        // locationManager.stopUpdatingLocation()  // Stop further updates to save battery
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Reverse geocoding failed: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No placemark found")
                return
            }
            
            self.city = placemark.locality ?? "-"
            self.country = placemark.country ?? "-"
            
            print("City: \(self.city), Country: \(self.country)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        locationError = error
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            locationManager.requestLocation()
        }
    }
    
}
