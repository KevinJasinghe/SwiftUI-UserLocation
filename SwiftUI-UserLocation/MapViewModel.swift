//
//  MapViewModel.swift
//  SwiftUI-UserLocation
//
//  Created by Kevin Jasinghe on 2022-04-03.
//


import MapKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 43.653225, longitude: -79.383186)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate  {
    
        @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation,
                                                   span: MapDetails.defaultSpan)
    
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Location Services is off")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location is restricted")
        case .denied:
            print("Location was denied")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate,
                                        span: MapDetails.defaultSpan)
        @unknown default:
            break
        }

    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}


