//
//  ScanViewController.swift
//  smogify
//
//  Created by ajapps on 7/23/22.
//

import UIKit
import SceneKit
import Vision
import ARKit

class ScanViewController: UIViewController, SCNSceneRendererDelegate, ARSCNViewDelegate, ARSessionDelegate {


    @IBOutlet weak var sceneView: ARSCNView!
    var sceneController = MainScene()
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
        if let scene = sceneController.scene{
            sceneView.scene = scene
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.delegate = self
        sceneView.session.run(configuration)
        
//        configure Model Serving
        setupCoreML()
//        run image-recognition model every .1 seconds
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:#selector(self.loopCoreMLUpdate), userInfo: nil, repeats: true)
        
        
        
    }
    
    let currentMLModel = TBD_Final().model
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
            
            
            
            
            
            
                DispatchQueue.main.async {
        //            very handy later on for displaying confidence
                    let prediction_label = self.view.viewWithTag(101) as? UILabel
                    prediction_label!.text = classifications
                    
                    let topPrediction = classifications.components(separatedBy: "\n")[0]
                    let topPredictionName = topPrediction.components(separatedBy: ":")[0].trimmingCharacters(in: .whitespaces)
                    guard let topPredictionScore: Float = Float(topPrediction.components(separatedBy: ":")[1].trimmingCharacters(in: .whitespaces)) else { return }
                    
                    
                    //prone to errors
                    
                    if (topPredictionScore > 0.95) && (topPredictionName != "no_product_detected"){
                        
                        
                        
                        
                            
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



