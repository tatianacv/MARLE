//
//  AccountCreation.swift
//  EncuestaMarle
//
//  Created by Tatiana Castro on 5/21/19.
//  Copyright © 2019 Marle. All rights reserved.
//

import ResearchKit

class AccountCreation: ORKRegistrationStep {
    override init(identifier: String) {
        super.init(identifier: identifier)
        
        let registrationTitle = NSLocalizedString("Registration", comment: "")
        let passcodeValidationRegularExpressionPattern = "^(?=.*\\d).{4,8}$"
        let passcodeValidationRegularExpression = try! NSRegularExpression(pattern: passcodeValidationRegularExpressionPattern)
        let passcodeInvalidMessage = NSLocalizedString("A valid password must be 4 to 8 characters long and include at least one numeric character.", comment: "")
        let registrationOptions: ORKRegistrationStepOption = [.includeGivenName, .includeFamilyName, .includeGender, .includeDOB]
        let registrationStep = ORKRegistrationStep(identifier: "registration", title: registrationTitle, text: "Register for MARLE Study", passcodeValidationRegularExpression: passcodeValidationRegularExpression, passcodeInvalidMessage: passcodeInvalidMessage, options: registrationOptions)
        
        /*
         A wait step allows you to upload the data from the user registration onto your server before presenting the verification step.
         */
        let waitTitle = NSLocalizedString("Creating account", comment: "")
        let waitText = NSLocalizedString("Please wait while we upload your data", comment: "")
        let waitStep = ORKWaitStep(identifier: "wait_step")
        waitStep.title = waitTitle
        waitStep.text = waitText
        
//        return ORKOrderedTask(identifier: String(describing:Identifier.accountCreationTask), steps: [
//            registrationStep,
//            waitStep
//            ])
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
