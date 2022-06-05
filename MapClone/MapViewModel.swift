//
//  MapViewModel.swift
//  MapClone
//
//  Created by DaeSeong on 2022/06/04.
//

import Foundation
import CoreLocation
import MapKit

final class MapViewModel: NSObject,ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5666791, longitude: 126.9782914), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var locationManager : CLLocationManager?
    
    func checkLocationManagerIsEnabled() {
        
        // 위치서비스가 켜져있으면
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        }else{
            print("위치서비스켜라")
        }
            
    }
    
    private  func checkLocationAuthorization(){
        guard let locationManager = locationManager else {
            return
        }

        switch locationManager.authorizationStatus {
            
         // 설정안되어있음
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        
        // 위치서비스가 꺼져있나?
        case .restricted:
            print("a")
        // 사용 안함
        case .denied:
            print("b")
       // 한번허용함, 앱을 사용하는 동안 허용
        case .authorizedAlways, .authorizedWhenInUse:
            guard let locationCoorinate = locationManager.location?.coordinate else {return}
            region = MKCoordinateRegion(center: locationCoorinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5) )
 
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
         
    }
}
