
//
//  ContentView.swift
//  swiftuitest
//
//  Created by ajapps on 7/24/22.


import SwiftUI
import MapKit
import CoreLocation


struct Spot: Identifiable{
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}



struct ContentView: View {

    
    
    @StateObject private var viewModel = ContentViewModel()

    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))

    
    var annotations: [Spot]
    
    
    
    
    
    
        var body: some View {
            
            
        
            
            
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: annotations){

        
            MapAnnotation(coordinate: $0.coordinate) {
                
                Circle()
                    .strokeBorder(.red, lineWidth: 4)
                    .frame(width: 40, height: 40)
                
                    
            
                    
                
            }
            
            
            
            
        }.ignoresSafeArea()
            .accentColor(Color(.systemPink))
            .onAppear {
                
                viewModel.checkIfLocationServicesIsEnabled()
            }
        
        

    }
}



final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{

    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60, longitude: 60), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @Published var p1 = CLLocationCoordinate2D(latitude: 20, longitude: 20)
    
    
    @Published var annotations = [
            Spot(coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)),
            Spot(coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508)),
            Spot(coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5)),
            Spot(coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667))
        ]
    
    
    
    
 
    var coordinates: [CLLocationCoordinate2D]?

    var locationManager: CLLocationManager?

    func checkIfLocationServicesIsEnabled(){
        
        
   
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager?.activityType = .automotiveNavigation
            locationManager!.delegate = self

        }
        else{
            //alert
        }
    }

    func checkLocationAuthorization(){
        guard let locationManager = locationManager else{return}

        switch locationManager.authorizationStatus{

        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate,       span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            p1 = locationManager.location!.coordinate
        @unknown default:
            break
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }


}
