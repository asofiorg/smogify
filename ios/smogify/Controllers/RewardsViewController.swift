//
//  RewardsViewController.swift
//  smogify
//
//  Created by ajapps on 7/23/22.
//

import UIKit
import WebKit

class RewardsViewController: UIViewController, WKUIDelegate {


        
        
    @IBOutlet weak var webView: WKWebView!
    

        override func viewDidLoad() {
            super.viewDidLoad()
            
            var myURL: URL!
            myURL = URL(string: "https://whatismyviewport.com/")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            
        }

}
