//
//  ScanViewController.swift
//
//
//  Created by ajapps on 7/23/22.
//

import UIKit
import SceneKit
import Vision
import ARKit
import CoreLocation



class ScanViewController: UIViewController, SCNSceneRendererDelegate, ARSCNViewDelegate, ARSessionDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    let postMaker = PostCalls(lat: 0, lng: 0, smog: false)


    var locationManager: CLLocationManager?
    var userLocation: CLLocationCoordinate2D?
//    var circle: CircleData?
//    scene view items
    @IBOutlet weak var sceneView: ARSCNView!
    
//    locked view items
    @IBOutlet weak var lockedView: UIView!
    var isLoggedIn: Bool = false
    @IBOutlet weak var registerButton: UIButton!
    var cellIndex: Int = 0
    
    
    
    
    var sceneController = MainScene()
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.isHidden = true
        lockedView.isHidden = true
        self.checkIfLocationServicesIsEnabled()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        renderScanView(isLoggedIn)
        createSession(isLoggedIn)
        renderLockedView(isLoggedIn)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        sceneView.stop(self)
    }
    
    

//    below is the code for lockedView
    

    
    func renderLockedView(_ loggedIn : Bool){
        if(isLoggedIn){return}
        
        lockedView.isHidden = false
        registerButton.layer.cornerRadius = 15
        
        
        
        
    }
    let items = [["1", "2", "3", "4"], ["5", "6", "7", "8"]]

    
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        print("at least this")
        renderScanView(true)
        createSession(true)
        renderLockedView(true)
        print("at least that")
        
    }
    
    
    
//collection views
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath as IndexPath) as! StyledCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        
                
        let cellColor = cell.viewWithTag(102)!
                
        cellColor.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        let label = cell.viewWithTag(103) as! UILabel
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        if(collectionView.tag == 200){
            label.text = items[0][indexPath.row]
        }
        else{
            label.text = items[1][indexPath.row]
        }
        
        cellIndex+=1;
        collectionView.reloadData()
        
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth = 5.0
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.masksToBounds = true
        cell.contentView.layer.cornerRadius = 15.0
        cell.contentView.layer.borderWidth = 5.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        cell.layer.shadowRadius = 6.0
        cell.layer.shadowOpacity = 0.6
        cell.layer.cornerRadius = 15.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    
    
    
// below is the code for scanView
    
    
    func renderScanView(_ loggedIn : Bool){
        if(loggedIn == false){return}

        lockedView.removeFromSuperview()

        sceneView.isHidden = false

        sceneView.delegate = self
        if let scene = sceneController.scene{
            sceneView.scene = scene
        }

        // configure Model Serving
        setupCoreML()

        // run image-recognition model every .1 seconds
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:#selector(self.loopCoreMLUpdate), userInfo: nil, repeats: true)
        
    }
    
    
    func createSession(_ loggedIn : Bool){
        if(loggedIn == false){return}
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.delegate = self
        sceneView.session.run(configuration)
    }
    
    
    let currentMLModel = SmogDetector().model
    private let serialQueue = DispatchQueue(label: "com.ajapps.dispatchqueueml")
    private var visionRequests = [VNRequest]()
    private var timer = Timer()

    private func setupCoreML() {
        guard let selectedModel = try? VNCoreMLModel(for: currentMLModel) else {
            fatalError("Could not load model.")
        }
        
        let classificationRequest = VNCoreMLRequest(model: selectedModel, completionHandler: classificationCompleteHandler)
       
        classificationRequest.imageCropAndScaleOption = VNImageCropAndScaleOption.centerCrop // Crop from centre of images and scale to appropriate size.
        visionRequests = [classificationRequest]
    }
    
    
    @objc private func loopCoreMLUpdate() {
        serialQueue.async {
            self.updateCoreML()
        }
    }


}

extension ScanViewController {
    private func updateCoreML() {
        let pixbuff : CVPixelBuffer? = (sceneView.session.currentFrame?.capturedImage)
        if pixbuff == nil { return }
        
        let deviceOrientation = UIDevice.current.orientation.getImagePropertyOrientation()
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixbuff!, orientation: deviceOrientation,options: [:])
        do {
            try imageRequestHandler.perform(self.visionRequests)
        } catch {
            print(error)
        }
        
    }
}





extension ScanViewController {
    
        private func classificationCompleteHandler(request: VNRequest, error: Error?) {
            if error != nil {
                print("Error: " + (error?.localizedDescription)!)
                return
            }
            guard let observations = request.results else {
                return
            }
            
            //change
            let classifications = observations[0...1]
                .compactMap({ $0 as? VNClassificationObservation })
                .map({ "\($0.identifier) \(String(format:" : %.2f", $0.confidence))" })
                .joined(separator: "\n")
            
            //print("Classifications: \(classifications)")
            
            
            
            
            
            
            DispatchQueue.main.async { [self] in
        //            very handy later on for displaying confidence
                    let prediction_label = self.view.viewWithTag(101) as? UILabel
                    prediction_label!.text = classifications
                    
                    let topPrediction = classifications.components(separatedBy: "\n")[0]
                    let topPredictionName = topPrediction.components(separatedBy: ":")[0].trimmingCharacters(in: .whitespaces)
                    guard let topPredictionScore: Float = Float(topPrediction.components(separatedBy: ":")[1].trimmingCharacters(in: .whitespaces)) else { return }
                    
                    
                    //prone to errors
                    
                    if (topPredictionScore > 0.95) && (topPredictionName != "clear"){
                        
                        
                        self.postMaker.smog = true
                        self.postMaker.lat = userLocation!.latitude
                        self.postMaker.lng = userLocation!.longitude
                        self.postMaker.apiCall()
                        
                        
                            
                            print("Top prediction: \(topPredictionName) - score: \(String(describing: topPredictionScore))")
                        
                        }
                        


                            
            }
    }
}


extension UIDeviceOrientation {
    func getImagePropertyOrientation() -> CGImagePropertyOrientation {
        switch self {
        case UIDeviceOrientation.portrait, .faceUp: return CGImagePropertyOrientation.right
        case UIDeviceOrientation.portraitUpsideDown, .faceDown: return CGImagePropertyOrientation.left
        case UIDeviceOrientation.landscapeLeft: return CGImagePropertyOrientation.up
        case UIDeviceOrientation.landscapeRight: return CGImagePropertyOrientation.down
        case UIDeviceOrientation.unknown: return CGImagePropertyOrientation.right
        }
    }
}




extension ScanViewController: CLLocationManagerDelegate{
    
    
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
            userLocation = locationManager.location?.coordinate
//            circle?.lat = locationManager.location?.coordinate.latitude
//            circle?.lon = locationManager.location?.coordinate.longitude

        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    
}
