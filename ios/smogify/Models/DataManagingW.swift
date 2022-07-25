//
//  DataManaging.swift
//  smogify
//
//  Created by ajapps on 7/24/22.
//

import Foundation

protocol DataManagingWDelegate{
    func didUpdateData(_ dataManaging: DataManagingW, data: DataModelW)
    func didFailWithError(error: Error)
}



struct DataManagingW{
    let dataURL = "https://smogify.up.railway.app/reports"

    var delegate: DataManagingWDelegate?
    
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
    func parseJSON(_ reportData: Foundation.Data) -> DataModelW? {

        
        let decoder = JSONDecoder()
        do {
            
            var theData = DataModelW(coordinates: [[]], entries: 0)
            var coordinate: [Double] = []
            var entriesF: Int = 0
            let decodedData = try decoder.decode([ReportData].self, from: reportData)
            theData.coordinates.removeAll()
            for entry in decodedData{
                entriesF+=1
                coordinate = [entry.lat, entry.lng]
                theData.coordinates.append(coordinate)
                print(coordinate)
            }
            theData.entries = entriesF
            return theData
            
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
