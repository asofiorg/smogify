//
//  MapViewController.swift
//  smogify
//
//  Created by ajapps on 7/24/22.
//google maps bc mapkit is full of bugs

import UIKit
import CoreLocation

class MapViewController: UIViewController {
    
    var dataManaging = DataManaging()
    var coordinates: [CLLocationCoordinate2D]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.dataManaging.delegate = self
            self.dot()
        }
        
        
        
    }
    func dot(){
            self.dataManaging.fetchData()
        
    }
    
    
    

}


extension MapViewController: DataManagingDelegate{
    func didUpdateData(_ dataManaging: DataManaging, data: DataModel) {
        print("hi")
//        for coord in data.coordinates{
//            self.coordinates.append(CLLocationCoordinate2D(latitude: coord[0], longitude: coord[1]))
//            print("Coordinate{\(coord[0])º , \(coord[1])º}")
//        }
    }
    
    func didFailWithError(error: Error) {
        print("sh")

                print("THE ERROR IS: \(error)")
    }
    
    
}
