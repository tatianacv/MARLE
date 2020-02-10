//
//  ResearchContainerViewController.swift
//  EncuestaMarle
//
//  Created by Tatiana Castro on 5/20/19.
//  Copyright © 2019 Marle. All rights reserved.
//

import UIKit
import ResearchKit

var response_token = String()

func checkToken(){
    
    let request = NSMutableURLRequest(url: NSURL(string: "http://emaapp.online/checkToken.php")! as URL)
    request.httpMethod = "POST"
    let postString = "data=\(token)"
    request.httpBody = postString.data(using: String.Encoding.utf8)
    
    let task = URLSession.shared.dataTask(with: request as URLRequest) {
        data, response, error in
        
        if error != nil {
            print("error=\(String(describing: error))")
            return
        }
        
        print("response = \(String(describing: response))")
        
        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print("responseString = \(String(describing: responseString))")
    }
    task.resume()
}

class ResearchContainerViewController: UIViewController {
    
    var contentHidden = false {
        didSet {
            guard contentHidden != oldValue && isViewLoaded else { return }
            children.first?.view.isHidden = contentHidden
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if response_token == "EstaBaseDatos" {
            performSegue(withIdentifier: "toStudy", sender: self)        }
        else {
            performSegue(withIdentifier: "toOnboarding", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
    
    @IBAction func unwindToStudy(_ segue: UIStoryboardSegue) {
        performSegue(withIdentifier: "toStudy", sender: self)
        
    }
    @IBAction func unwindToWithdrawl(_ segue: UIStoryboardSegue) {
        toWithdrawl()
    }
    func toWithdrawl() {
        let viewController = WithdrawViewController()
        viewController.delegate = self as? ORKTaskViewControllerDelegate
        
        present(viewController, animated: true, completion: nil)
    }
   
}

extension ResearchContainerViewController: ORKTaskViewControllerDelegate {
    
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        // Check if the user has finished the `WithdrawViewController`.
        if taskViewController is WithdrawViewController {
            if reason == .completed {
                performSegue(withIdentifier: "toOnboarding", sender: self)
            }
            dismiss(animated: true, completion: nil)
        }
    }
}


