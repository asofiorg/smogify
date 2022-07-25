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
        self.doo()
        
    }
    let dataURL = "https://ipapi.co/json"
    
    
    
    func doo(){
        let urlString = dataURL
        
        performRequest(with: urlString)
    }
    
    
    
    
    
    
    func performRequest(with urlString: String){
        
        //fetches data and URL To create a URLSession, assign a task to the session and carry out the task.
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil{
                    print(error)
                    return
                }
                
                if let safeData = data{
                    if let data =  self.parseJSON(safeData){
                        
                        self.uuid = data.uuid
                        print("UUID IS: \(self.uuid)" )
                        
                    }
                }
                
            }
             task.resume()
        }
        
    }
    
    func parseJSON(_ mapData: Foundation.Data) -> DataModel? {
        print("???")
        
        let decoder = JSONDecoder()
        do {
            
            
            
            
                let decodedData = try decoder.decode(MapData.self, from: mapData)

             
            
            
            var ip = decodedData.ip
            
                
            return DataModel(uuid: ip)
            
        }catch{
            print("ERROR")
            return nil
        }
    }
    
    
    
    
    func apiCall(){
        
        
    
        
        
    
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


