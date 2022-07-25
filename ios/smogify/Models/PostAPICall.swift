//
//  PostAPICall.swift
//  smogify
//
//  Created by ajapps on 7/24/22.
//

import Foundation

class PostCalls{
    
    
    var uuid = "191.102.218.214"
    var lat: Double
    var lng: Double
    var smog: Bool
    
    
    init(lat: Double, lng: Double, smog: Bool) {
        self.lat = lat
        self.lng = lng
        self.smog = smog
        
    }
    
    func apiCall(){
        
        
    
        
        
        let dataURL = "https://ipapi.co/json"
        
        
        
        
        
    
        guard let URL = URL(string: "https://smogify.up.railway.app/reports") else{
            return
        }

        var request = URLRequest(url: URL)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = nil
        let body: [String: AnyHashable] = [
              "uuid": uuid,
              "lat": lat,
              "lng": lng,
              "smog": smog
            
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do{
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("SUCCESS: \(response)")
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }

}


