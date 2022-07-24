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
        dataManaging.delegate = self
        dot()
        
        
    }
    func dot(){
        DispatchQueue.main.async {
            self.dataManaging.fetchData()
        }
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
        print("hi2")
        let alert = UIAlertController(title: "You are probably offline", message: "Connect to the internet to load map data", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                present(alert, animated: true, completion: nil)
                print("THE ERROR IS: \(error)")
    }
    
    
}
