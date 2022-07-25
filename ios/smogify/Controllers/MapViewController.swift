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
    
    var dataManagingW = DataManagingW()
    var coordinates: [CLLocationCoordinate2D]?
    var locationManager: CLLocationManager?
    var userLocation: CLLocationCoordinate2D?
    var contentView: ContentView?
    var annotationsN = [Spot(coordinate: CLLocationCoordinate2D(latitude: 40.7, longitude: 74))]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            self.dataManagingW.delegate = self
            dot()
        
        
        
    
    }
    
    @IBSegueAction func segueToHostingController(_ coder: NSCoder) -> UIViewController? {
        
       
        let contentView = ContentView(annotations: annotationsN)
        
        return UIHostingController(coder: coder, rootView: contentView)
    }

    
    
    func dot(){
            self.dataManagingW.fetchData()
        
    }
    
    
    
    
    
   

}


extension MapViewController: DataManagingWDelegate{
    func didUpdateData(_ dataManaging: DataManagingW, data: DataModelW) {
        print("hi")
        self.annotationsN.removeAll()
        for coor in data.coordinates{
            self.annotationsN.append(Spot(coordinate: CLLocationCoordinate2D(latitude: coor[0], longitude: coor[1])))
        }
        contentView = ContentView(annotations: self.annotationsN)
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
