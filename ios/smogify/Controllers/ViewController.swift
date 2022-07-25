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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        signUpButton.layer.cornerRadius = 15
        


        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animationView.play(fromProgress: 0, toProgress: 1, loopMode: .loop)
    }

}



