//
//  MapViewController.swift
//  smogify
//
//  Created by ajapps on 7/24/22.
//google maps bc mapkit is full of bugs

import UIKit
import CoreLocation
import MapboxMaps


class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MapView!

    var dataManaging = DataManaging()
    var coordinates: [CLLocationCoordinate2D]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.dataManaging.delegate = self
            self.dot()
            
        }
        
        
        let myResourceOptions = ResourceOptions(accessToken: "your_public_access_token")
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions)
        
       
         
        
        
        
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

