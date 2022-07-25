//
//  ViewController.swift
//  smogify
//
//  Created by ajapps on 7/22/22.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    @IBOutlet weak var signUpButton: UIButton!

    @IBOutlet weak var animationView: AnimationView!
    
    var dataManaging = DataManagingW()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.layer.cornerRadius = 15
        
        DispatchQueue.main.async {
            self.dataManaging.delegate = self
            self.dataManaging.fetchData()
        }

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animationView.play(fromProgress: 0, toProgress: 1, loopMode: .loop)
    }

}


extension ViewController: DataManagingWDelegate{
    func didUpdateData(_ dataManaging: DataManagingW, data: DataModelW) {
        print("success")
    }
    func didFailWithError(error: Error) {
        print("fail the error is: \(error)")
    }
}

