//
//  Encuesta_MARLE.swift
//  Created by Tatiana Castro on 1/18/19.
//  Copyright © 2019 Tatiana Castro. All rights reserved.
//

import UIKit
import ResearchKit
import Foundation

public var EncuestaMarle: ORKOrderedTask {
    var steps = [ORKStep]()
    
    let instruccion = ORKInstructionStep(identifier: "Instrucción")
    instruccion.title = "Proyecto MARLE"
    instruccion.text = descripcion
    steps += [instruccion]
        
    for i in 1...cantidad_preguntas{
        switch tipo_preg[i-1] {
        case "3":
            let escala1Formato = ORKAnswerFormat.scale(withMaximumValue: Int(max_values[i-1]) ?? 0, minimumValue: 1, defaultValue: NSIntegerMax, step: 1, vertical: false, maximumValueDescription: "Máximo", minimumValueDescription: "Mínimo")
            let escala1Pregunta = ORKQuestionStep(identifier: id_preg[i-1] , title: "Pregunta \(i)", question: preguntas[i-1], answer: escala1Formato)
            steps += [escala1Pregunta]
            
        case "2":
            let respuestaFormato = ORKAnswerFormat.textAnswerFormat()
            let respuestaStep = ORKQuestionStep(identifier: id_preg[i-1], title: NSLocalizedString("Pregunta \(i)", comment: ""), question: preguntas[i-1], answer: respuestaFormato);
            steps += [respuestaStep]
            
        case "1":
            var textChoices = [ORKTextChoice]()
            for j in 1...(Int(max_values[i-1]) ?? 0){
                if j==1{
                    textChoices.append(ORKTextChoice(text: String(j)+"    "+min_text[1], value: String(j) as NSCoding & NSCopying & NSObjectProtocol))
                }
                else if j==(Int(max_values[i-1])){
                    textChoices.append(ORKTextChoice(text: String(j)+"    "+max_text[cantidad_preguntas-1], value: String(j) as NSCoding & NSCopying & NSObjectProtocol))
                }
                else{
                textChoices.append(ORKTextChoice(text: String(j), value: String(j) as NSCoding & NSCopying & NSObjectProtocol))
                }
            }
            let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
            let questionStep = ORKQuestionStep(identifier: id_preg[i-1], title: NSLocalizedString("Pregunta \(i)", comment: ""), question: preguntas[i-1], answer: answerFormat)
            steps += [questionStep]
            
        default:
            let respuestaFormato = ORKAnswerFormat.textAnswerFormat()
            let respuestaStep = ORKQuestionStep(identifier: id_preg[i-1], title: NSLocalizedString("Pregunta \(i)", comment: ""), question: preguntas[i-1], answer: respuestaFormato);
            steps += [respuestaStep]
        }
    }
    let completionStep = ORKCompletionStep(identifier: "CompletionStep")
    completionStep.title = "Thank you for answering."
    completionStep.text = "Your answers have been recorded."
    steps += [completionStep]
    return ORKOrderedTask(identifier: id_questionario, steps: steps)
}
