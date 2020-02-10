//
//  StartViewController.swift
//  EncuestaMarle
//
//  Created by Tatiana Castro on 5/20/19.
//  Copyright © 2019 Marle. All rights reserved.
//

import UIKit
import FirebaseAuth

class StartViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
        }
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
