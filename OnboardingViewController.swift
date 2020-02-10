//
//  OnboardingViewController.swift
//  EncuestaMarle
//
//  Created by Tatiana Castro on 5/21/19.
//  Copyright © 2019 Marle. All rights reserved.
//

import UIKit
import ResearchKit

var jsonDict_reg = [String: Any]()
var n_jsonDict_reg = [String: Any]()
var jsonDict_r = [String: Any]()
var jsonString_reg = String()
var jsonString_r = String()
var jsonData_reg = Data()
var response_reg = String()
var response_r = String()
var task = ORKTaskViewController()
var consentDocument = ConsentDocument()
var task_def = String()

func getConsent_task(task: ORKTaskViewController) -> ORKTaskViewController{
    return task
}

func limpiarJson_reg(){
    let resultados_encuestas = jsonDict_reg["results"] as! [[String:Any]]
    if let resultado_pregunta = resultados_encuestas[2]["results"] as? [[String:Any]]{
        n_jsonDict_reg["token"]=token
        n_jsonDict_reg["email"]=resultado_pregunta[0]["textAnswer"]
        n_jsonDict_reg["password"]=resultado_pregunta[1]["textAnswer"]
        n_jsonDict_reg["gender"]=resultado_pregunta[3]["choiceAnswers"]
        n_jsonDict_reg["job"]=resultado_pregunta[4]["choiceAnswers"]
        let date = resultado_pregunta[5]["dateAnswer"] as! String
        n_jsonDict_reg["yearBirth"]=date.prefix(4)
    }
}

func sendJson_reg() {
    let request = NSMutableURLRequest(url: NSURL(string: "http://emaapp.online/registration.php")! as URL)
    request.httpMethod = "POST"
    let postString = "data=\(jsonString_reg)"
    request.httpBody = postString.data(using: String.Encoding.utf8)
    
    let task = URLSession.shared.dataTask(with: request as URLRequest) {
        data, response, error in
        if error != nil {
            print("error=\(String(describing: error))")
            return
        }
        
        print("response solito = \(String(describing: response))") //Error: 1062
        
        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print("responseString reg= \(String(describing: responseString))")
        
        response_reg = responseString as! String
    }
    task.resume()
}

func sendJson_r() {
    let request = NSMutableURLRequest(url: NSURL(string: "http://emaapp.online/recoverAccount.php")! as URL)
    request.httpMethod = "POST"
    let postString = "data=\(jsonString_r)"
    request.httpBody = postString.data(using: String.Encoding.utf8)
    
    let task = URLSession.shared.dataTask(with: request as URLRequest) {
        data, response, error in
        if error != nil {
            print("error=\(String(describing: error))")
            return
        }
        
        print("response solito = \(String(describing: response))") //Error: 1062
        
        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print("responseString reg= \(String(describing: responseString))")
        
        response_r = responseString as! String
    }
    task.resume()
}

class OnboardingViewController: UIViewController {    
    @IBAction func joinButtonTapped(_ sender: UIButton) {
        let consentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
        
        let registrationTitle = NSLocalizedString("Registration", comment: "")
        let passcodeValidationRegularExpressionPattern = "^(?=.*\\d).{4,8}$"
        let passcodeValidationRegularExpression = try! NSRegularExpression(pattern: passcodeValidationRegularExpressionPattern)
        let passcodeInvalidMessage = NSLocalizedString("A valid password must be 4 to 8 characters long and include at least one numeric character.", comment: "")
        let registrationOptions: ORKRegistrationStepOption =  [.includeGender, .includeDOB, .includeJob]
        let registrationStep = ORKRegistrationStep(identifier: "registration", title: registrationTitle, text: "Register for MARLE Study", passcodeValidationRegularExpression: passcodeValidationRegularExpression, passcodeInvalidMessage: passcodeInvalidMessage, options: registrationOptions)
        
        let signature = consentDocument.signatures!.first!
        let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consentDocument)
        
        reviewConsentStep.text = "Review the consent form."
        reviewConsentStep.reasonForConsent = "Consent to join the MARLE Study."
        
        let passcodeStep = ORKPasscodeStep(identifier: "Passcode")
        passcodeStep.text = "Now you will create a passcode to identify yourself to the app and protect access to information you've entered."
        
        
        let completionStep = ORKCompletionStep(identifier: "CompletionStep")
        completionStep.title = "Welcome aboard."
        completionStep.text = "Thank you for joining this study."
    
        print("checko")
        task_def = "registration"
        let orderedTask = ORKOrderedTask(identifier: "Join", steps: [consentStep, reviewConsentStep, registrationStep])
        let taskViewController = ORKTaskViewController(task: orderedTask, taskRun: nil)
        taskViewController.delegate = self
        if response_reg == "Error: email"{
            let orderedTask = ORKOrderedTask(identifier: "Join", steps: [consentStep, reviewConsentStep, registrationStep])
            let taskViewController = ORKTaskViewController(task: orderedTask, taskRun: nil)
            taskViewController.delegate = self
            present(taskViewController, animated: true){
                let alertTitle = NSLocalizedString("Error: Email Already Registered", comment: "")
                let alertMessage = NSLocalizedString("The email used is already registered.", comment: "")
                let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                taskViewController.present(alert, animated: true, completion: nil)
                self.performSegue(withIdentifier: "toOnboarding", sender: nil)
            }
        }
        else if response_reg == "Error: token"{
            let orderedTask = ORKOrderedTask(identifier: "Join", steps: [consentStep, reviewConsentStep, registrationStep])
            let taskViewController = ORKTaskViewController(task: orderedTask, taskRun: nil)
            taskViewController.delegate = self
            present(taskViewController, animated: true){
                let alertTitle = NSLocalizedString("Error: Phone Already Used", comment: "")
                let alertMessage = NSLocalizedString("This phone has been used to create an account already. Please contact your mentor.", comment: "")
                let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                taskViewController.present(alert, animated: true, completion: nil)
                self.performSegue(withIdentifier: "toOnboarding", sender: nil)
            }
        }
        else{
            let c_orderedTask = ORKOrderedTask(identifier: "Join", steps: [consentStep, reviewConsentStep, registrationStep, completionStep])
            let c_taskViewController = ORKTaskViewController(task: c_orderedTask, taskRun: nil)
            c_taskViewController.delegate = self
            present(c_taskViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func recover_account(_ sender: UIButton) {
        class LoginViewController : ORKLoginStepViewController {
            override func forgotPasswordButtonTapped() {
                let alertTitle = NSLocalizedString("Help", comment: "")
                let alertMessage = NSLocalizedString("You will need to contact your P.I., so they can determine the next steps.", comment: "")
                let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        let loginTitle = NSLocalizedString("Recover Account", comment: "")
        let loginStep = ORKLoginStep(identifier: "recover" , title: loginTitle, text: "Fill out information to recover account", loginViewControllerClass: LoginViewController.self)
        
        let orderedTask = ORKOrderedTask(identifier: "Join", steps: [loginStep])
        let taskViewController = ORKTaskViewController(task: orderedTask, taskRun: nil)
        taskViewController.delegate = self
        
        task_def = "recover"
        present(taskViewController, animated: true, completion: nil)

    }
    
}

extension OnboardingViewController : ORKTaskViewControllerDelegate {
    
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        switch reason {
        case .completed:
            if task_def == "recover"{
                let taskResult_r = taskViewController.result
                let jsonData_r = try! ORKESerializer.jsonData(for: taskResult_r)
                jsonString_r = NSString(data: jsonData_r, encoding: String.Encoding.utf8.rawValue)! as String
                jsonDict_r = convertToDictionary(text: jsonString_r as String) as! [String: Any]
                do {
                    let jsonData_r = try JSONSerialization.data(withJSONObject: jsonDict_r, options: .prettyPrinted)
                    jsonString_r = NSString(data: jsonData_r, encoding: String.Encoding.utf8.rawValue)! as String
                }
                catch {
                    print(error.localizedDescription)
                }
                sendJson_r()
                if response_r == "Error: no"{
                    let alertTitle = NSLocalizedString("Incorrect cerdentials", comment: "")
                    let alertMessage = NSLocalizedString("The password and/or email provided were not found.", comment: "")
                    let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    performSegue(withIdentifier: "toOnboarding", sender: nil)
                }
//                else if response_r == "Error: token"{
//                    let alertTitle = NSLocalizedString("Token found", comment: "")
//                    let alertMessage = NSLocalizedString("The password and/or email provided were not found.", comment: "")
//                    let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
//                    performSegue(withIdentifier: "toOnboarding", sender: nil)
//                }
                else{
                    performSegue(withIdentifier: "unwindToStudy", sender: nil)
                }
            }
            else{
//                let taskResult_reg = taskViewController.result
//                let signatureResult = taskResult_reg as! ORKConsentSignatureResult
//                let signature = signatureResult.signature!
//                print(signature)
                let jsonData_reg = try! ORKESerializer.jsonData(for: taskResult_reg)
                jsonString_reg = NSString(data: jsonData_reg, encoding: String.Encoding.utf8.rawValue)! as String
                jsonDict_reg = convertToDictionary(text: jsonString_reg as String) as! [String: Any]
                limpiarJson_reg()
                do {
                    let jsonData_reg = try JSONSerialization.data(withJSONObject: n_jsonDict_reg, options: .prettyPrinted)
                    jsonString_reg = NSString(data: jsonData_reg, encoding: String.Encoding.utf8.rawValue)! as String
                }
                catch {
                    print(error.localizedDescription)
                }
                sendJson_r()
//                if response_reg == "Error: email"{
//                    present(taskViewController, animated: true){
//                        let alertTitle = NSLocalizedString("Error: Email Already Registered", comment: "")
//                        let alertMessage = NSLocalizedString("The email used is already registered.", comment: "")
//                        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//                        taskViewController.present(alert, animated: true, completion: nil)
//                        self.performSegue(withIdentifier: "toOnboarding", sender: nil)
//                    }
//                }
//                else if response_reg == "Error: token"{
//                    present(taskViewController, animated: true){
//                        let alertTitle = NSLocalizedString("Error: Phone Already Used", comment: "")
//                        let alertMessage = NSLocalizedString("This phone has been used to create an account already. Please contact your mentor.", comment: "")
//                        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//                        taskViewController.present(alert, animated: true, completion: nil)
//                        self.performSegue(withIdentifier: "toOnboarding", sender: nil)
//                    }
//                }
//                else{
//                    present(taskViewController, animated: true){
//                        let completionStep = ORKCompletionStep(identifier: "CompletionStep")
//                        completionStep.title = "Welcome aboard."
//                        completionStep.text = "Thank you for joining this study."
//                        let orderedTask = ORKOrderedTask(identifier: "Join", steps: [completionStep])
//                        let c_taskViewController = ORKTaskViewController(task: orderedTask, taskRun: nil)
//                        c_taskViewController.delegate = self
//                        taskViewController.present(c_taskViewController, animated: true)
//                    }
//                }
            }
            
        case .discarded, .failed, .saved:
            dismiss(animated: true, completion: nil)
        }
    }
}
