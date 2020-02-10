//
//  ConsentDocument.swift
//  EncuestaMarle
//
//  Created by Tatiana Castro on 5/21/19.
//  Copyright © 2019 Marle. All rights reserved.
//

import ResearchKit

class ConsentDocument: ORKConsentDocument {
    
    override init() {
        super.init()
        
        title = NSLocalizedString("MARLE Consent Form", comment: "")
        
        sections = []
        
        let section1 = ORKConsentSection(type: .overview)
        section1.summary = "You have been invited to participate in this study whose objectives are (1) to develop and demonstrate the utility of a mobile application (MARLE) to collect perception data of students participating in research experiences and (2) to use MARLE to determine the sources of self-efficacy that lead to career exploration and decision-making in undergraduate students."
        section1.content = "You have been invited to participate in this study whose objectives are (1) to develop and demonstrate the utility of a mobile application (MARLE) to collect perception data of students participating in research experiences and (2) to use MARLE to determine the sources of self-efficacy that lead to career exploration and decision-making in undergraduate students. This study is been carried out under the supervision of Dr. Juan S. Ramírez Lugo, Department of Biology and Dr. Carlos Corrada Bravo, Department of Computer Sciences at the University of Puerto Rico, Rio Piedras Campus. You were selected to participate in this study because you are enrolled in a course that offers a research experience or you voluntarily participate in research with a professor affiliated to the Río Piedras Campus."
        if sections == nil {
            sections = [section1]
        } else {
            sections!.append(section1)
        }
        
        let section2 = ORKConsentSection(type: .timeCommitment)
        section2.summary = "In the study you will be asked to answer a questionnaire, about your perception of self-efficacy in research, scientific identity and decision-making about your professional career at the beginning and end of your research experience."
        section2.content = "In the study you will be asked to answer a questionnaire, about your perception of self-efficacy in research, scientific identity and decision-making about your professional career at the beginning and end of your research experience. It will take you between 10-20 minutes to answer this questionnaire. You are also expected to respond to short questionnaires between 1-3 times per week while you are participating in the research. You will receive notifications at random times during your research experience and answer questions adapted from survey instruments that have been previously validated. It will take you between 1-3 minutes to answer these questionnaires. It is expected that 25 students will participate in this phase of the study."
        if sections == nil {
            sections = [section2]
        } else {
            sections!.append(section2)
        }
        
        let section3 = ORKConsentSection(type: .dataGathering)
        section3.summary = "While answering the questions, you may feel uncomfortable because the questions are about your general opinion about science and research and your career. If you feel uncomfortable with the questions, you can stop and choose not to answer the question. "
        section3.content = "While answering the questions, you may feel uncomfortable because the questions are about your general opinion about science and research and your career. If you feel uncomfortable with the questions, you can stop and choose not to answer the question. When you download the application, it will occupy space in the memory of your mobile device and also consume your data plan in the transmission of information when you answer the questionnaires. It is estimated that the application will have a size of 40 Mb (As reference the WhatsApp application is 88.9 Mb). Although at the moment we cannot say exactly how much memory or data you will consume, we understand that both will be minimal. The risks of this study are minimal. "
        if sections == nil {
            sections = [section3]
        } else {
            sections!.append(section3)
        }
        
        let section4 = ORKConsentSection(type: .privacy)
        section4.summary = "Your identity will be protected throughout the study."
        section4.content = "Your identity will be protected throughout the study. Your identifiable information will be handled confidentially and when presenting the results of the investigation you will not be identified. The information you issue through the application will be through access credentials (username and password) that only you will know. These access credentials will be encrypted and any subsequent association between you and your data will be made by reference to the encrypted information, not your personal identity. The data collected through the questionnaires will be stored digitally on a secure hard drive in the researcher's office. These data will also be stored virtually in the cloud, with access limited only to researchers."
        if sections == nil {
            sections = [section4]
        } else {
            sections!.append(section4)
        }
        
        let section5 = ORKConsentSection(type: .dataUse)
        section5.summary = "The data obtained will be used to improve academic offerings and research experiences."
        section5.content = "The data obtained will be used to improve academic offerings and research experiences. The results of this study may be part of a scientific publication on science education strategies and will serve as a basis to improve the teaching curriculum. It may be used to develop proposals for obtaining external funds for research. The officials of the Río Piedras Campus of the University of Puerto Rico and / or federal agencies responsible for ensuring the integrity of the research may require the researcher to prove the data obtained in this study, including this informed consent. \nThe information handled by your device can be intervened or revised by third parties. These people can be people with legitimate or illegitimate access to the device and its content such as a family member, employer, hackers, intruders, etc. In addition, the device that you use may keep track of the information you access or send over the Internet."
        if sections == nil {
            sections = [section5]
        } else {
            sections!.append(section5)
        }
        
        let section6 = ORKConsentSection(type: .onlyInDocument)
        section6.content = "If you decide to participate in this study, understand that your participation is completely voluntary and that you have the right to abstain from participating or even withdraw at any time of the study without incurring in any penalty. In the application you will find the instructions to withdraw from the study and stop receiving notifications if you wish. You also have the right not to answer any question if you wish. Your participation in this study will not affect in any way your academic evaluation in the courses in which you are carrying out this research. Finally, you have the right to receive a copy of this document.\nIf you have any questions or would like more information about this study, please contact Prof. Ramírez Lugo at 787-764-0000 Ext. 88068, at 787-918-5330 or by email at juan.ramirez3@upr.edu at any moment. If you have any questions about your rights as a participant or claim or complaint related to your participation in this study, you may contact the Compliance Officer of the Río Piedras Campus of the University of Puerto Rico, at telephone 764-0000, extension 86773 or cipshi. degi@upr.edu.\nYour signature on this document means that you have decided to participate voluntarily, that the information presented on this Consent Sheet has been discussed and that you have received a copy of this document. This printed sheet will be stored under lock and key for a period of 5 years after completion of the investigation and will then be shredded and discarded."
        if sections == nil {
            sections = [section6]
        } else {
            sections!.append(section6)
        }
        
        let signature = ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature")
        addSignature(signature)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ORKConsentSectionType: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .overview:
            return "Overview"
            
        case .dataGathering:
            return "Data Gathering"
            
        case .privacy:
            return "Privacy"
            
        case .dataUse:
            return "Data Use"
            
        case .timeCommitment:
            return "Time Commitment"
            
        case .studySurvey:
            return "StudySurvey"
            
        case .studyTasks:
            return "StudyTasks"
            
        case .withdrawing:
            return "Withdrawing"
            
        case .custom:
            return "Custom"
            
        case .onlyInDocument:
            return "OnlyInDocument"
        }
    }
}
