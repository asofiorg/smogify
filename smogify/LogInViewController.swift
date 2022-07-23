//
//  LogInViewController.swift
//  smogify
//
//  Created by ajapps on 7/22/22.
//

import UIKit

class LogInViewController: UIViewController {

    @IBAction func continuePressed(_ sender: Any) {
        performSegue(withIdentifier: "logInToMain", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
