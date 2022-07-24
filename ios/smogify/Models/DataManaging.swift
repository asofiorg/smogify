//
//  DataManaging.swift
//  smogify
//
//  Created by ajapps on 7/24/22.
//

import Foundation

protocol DataManagingDelegate{
    func didUpdateData(_ dataManaging: DataManaging, data: DataModel)
    func didFailWithError(error: Error)
}



struct DataManaging{
    let dataURL = "https://gist.githubusercontent.com/llanoajm/982bb007335a7a4bff8502c00b59ac0a/raw/bcdc3f76c4e8fc3bc35a19fbe12cbc06caeaa067/sample.json"

    var delegate: DataManagingDelegate?
    
    func fetchData(){
        
        
        
        let urlString = dataURL//"\(dataURL)&page=\(page)"
        
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String){
        
        //fetches data and URL To create a URLSession, assign a task to the session and carry out the task.
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let data =  self.parseJSON(safeData){
                        
                        self.delegate?.didUpdateData(self, data: data)
                        
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
            
            var theData = DataModel(coordinates: [[]])
            
            
                let decodedData = try decoder.decode(MapData.self, from: mapData)

                print("!!!")
            
            
                var coordinates: [[Double]] = []
            
            print(decodedData.type)

//            for num in 0...decodedData.features.count - 1{
//
//                let coord = decodedData.features[num].geometry.coordinates
//
//                coordinates.append(coord)
//
//
//            }
            let thisData = DataModel(coordinates: coordinates)
            theData = thisData
            
            
           
            
            return theData
            
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
