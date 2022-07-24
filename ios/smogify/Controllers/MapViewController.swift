//
//  MapViewController.swift
//  smogify
//
//  Created by ajapps on 7/24/22.
//google maps bc mapkit is full of bugs

import UIKit
import CoreLocation
import SwiftUI


class MapViewController: UIViewController {
    

    
    @IBOutlet weak var containerView: UIView!
    
    var dataManaging = DataManaging()
    var coordinates: [CLLocationCoordinate2D]?
    var locationManager: CLLocationManager?
    var userLocation: CLLocationCoordinate2D?
    
    var annotationsN = [
        Spot(coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)),
        Spot(coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508)),
        Spot(coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5)),
        Spot(coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667))
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.dataManaging.delegate = self
            self.dot()
        }
        
        
    
    }
    
    @IBSegueAction func segueToHostingController(_ coder: NSCoder) -> UIViewController? {
       
        let contentView = ContentView(annotations: annotationsN)
        
        return UIHostingController(coder: coder, rootView: contentView)
    }

    
    
    func dot(){
            self.dataManaging.fetchData()
        
    }
    
    
    
    
    
   

}


extension MapViewController: DataManagingDelegate{
    func didUpdateData(_ dataManaging: DataManaging, data: DataModel) {
        print("hi")
        for coord in data.coordinates{
//            print(coord)
            self.coordinates?.append(CLLocationCoordinate2D(latitude: coord[0], longitude: coord[1]))
            print("Coordinate{\(coord[0])º , \(coord[1])º}")
        }
    }
    
    func didFailWithError(error: Error) {
        print("sh")

                print("THE ERROR IS: \(error)")
    }
    
    
}
//
//
//extension MapViewController: CLLocationManagerDelegate{
//
//
//
//
//
//
//
//    func checkLocationAuthorization(){
//
//
//
//
//        guard let locationManager = locationManager else{return}
//
//        switch locationManager.authorizationStatus{
//
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        case .restricted:
//            print("restricted")
//        case .denied:
//            print("denied")
//        case .authorizedAlways, .authorizedWhenInUse:
//
//            userLocation = locationManager.location!.coordinate
//            print ("user is at \(userLocation!.latitude)º, \(userLocation!.latitude)º")
//            initializeUI()
//
//        @unknown default:
//            break
//        }
//
//    }
//
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        checkLocationAuthorization()
//    }
//}
