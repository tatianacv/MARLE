//
//  WithdrawViewController.swift
//  EncuestaMarle
//
//  Created by Tatiana Castro on 5/21/19.
//  Copyright © 2019 Marle. All rights reserved.
//

import UIKit
import ResearchKit

var withdrawDict = [String: String]()
var jsonString_withdraw = String()

func sendJson_withdraw(){
    
    let request = NSMutableURLRequest(url: NSURL(string: "http://emaapp.online/withdraw.php")! as URL)
    request.httpMethod = "POST"
    let postString = "data=\(jsonString_withdraw)"
    request.httpBody = postString.data(using: String.Encoding.utf8)
    
    let task = URLSession.shared.dataTask(with: request as URLRequest) {
        data, response, error in
        
        if error != nil {
            print("error=\(String(describing: error))")
            return
        }
        
        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print("responseString = \(String(describing: responseString))")
    } 
    task.resume()
}

class WithdrawViewController: ORKTaskViewController {
    
    init() {
        let instructionStep = ORKInstructionStep(identifier: "WithdrawlInstruction")
        instructionStep.title = NSLocalizedString("Are you sure you want to withdraw?", comment: "")
        instructionStep.text = NSLocalizedString("Withdrawing from the study will reset the app to the state it was in prior to you originally joining the study.", comment: "")
        
        let completionStep = ORKCompletionStep(identifier: "Withdraw")
        completionStep.title = NSLocalizedString("We appreciate your time.", comment: "")
        completionStep.text = NSLocalizedString("Thank you for your contribution to this study. We are sorry that you could not continue.", comment: "")
        
        let withdrawTask = ORKOrderedTask(identifier: "Withdraw", steps: [instructionStep, completionStep])
        
        withdrawDict["token"]=token
        withdrawDict["withdraw"]="yes"
        do {
            let jsonData_w = try JSONSerialization.data(withJSONObject: withdrawDict, options: .prettyPrinted)
            jsonString_withdraw = NSString(data: jsonData_w, encoding: String.Encoding.utf8.rawValue)! as String
        }
        catch {
            print(error.localizedDescription)
        }
        print(jsonString_withdraw)
        sendJson_withdraw()
        
        super.init(task: withdrawTask, taskRun: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
