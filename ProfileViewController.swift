//
//  ProfileViewController.swift
//  EncuestaMarle
//
//  Created by Tatiana Castro on 5/21/19.
//  Copyright © 2019 Marle. All rights reserved.
//

import UIKit
import ResearchKit

class ProfileViewController: UIViewController {

    @IBAction func see_consent(_ sender: Any) {
//        func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
//            switch reason {
//            case .completed:
//                let result = task.result
//                if let stepResult = result.stepResultForStepIdentifier("ConsentReviewStep"),
//                    let signatureResult = stepResult.results?.first as? ORKConsentSignatureResult {
//                    signatureResult.applyToDocument(consentDocument)
//                    
//                    consentDocument.makePDF { (data, error) -> Void in
//                        let tempPath = NSTemporaryDirectory() as NSString
//                        let path = tempPath.appendingPathComponent("signature.pdf")
//                        data?.writeToFile(path, atomically: true)
//                        print(path)
//                    }
//
//                }
//
//            default:
//                break
//            }
//        }
        }
//        func taskViewController(_ taskViewController: ORKTaskViewController?, didFinishWith reason: ORKTaskViewControllerFinishReason) throws {
//            switch reason {
//            case ORKTaskViewControllerFinishReasonCompleted:
//                var signatureResult = task.result.stepResult(forStepIdentifier: "consentReviewIdentifier").firstResult() as? ORKConsentSignatureResult
//                if signatureResult?.signature.signatureImage != nil {
//                    signatureResult?.signature.title = "\(signatureResult?.signature.givenName ?? "") \(signatureResult?.signature.familyName ?? "")"
//                    signatureResult?.apply(toDocument: consentDocument)
//
//                    consentDocument.makePDF(withCompletionHandler: { pdfFile, error in
//                        var paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
//                        var filePath = URL(fileURLWithPath: paths[0]).appendingPathComponent("Consent.pdf").absoluteString
//                        try? pdfFile?.write(toFile: filePath, options: .atomic)
//                    })
//                }
//            default:
//                break
//            }
//        }
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
