//
//  EncuestaViewController.swift
//  Encuesta_MARLE
//
//  Created by Tatiana Castro on 1/31/19.
//  Copyright © 2019 Tatiana Castro. All rights reserved.
//
import UIKit
import ResearchKit

var token = String()
let URL = "http://emaapp.online/getSubQ.php?tk="+token;
var preguntas = [String]()
var descripcion = String()
var id_preg = [String]()
var tipo_preg = [String]()
var cantidad_preguntas = Int()
var max_values = [String]()
var max_text = [String]()
var min_text = [String]()
var id_questionario = String()
var jsonString = String()
var jsonDict = [String: Any]()
var n_jsonDict = [String: Any]()
var response_survey = String()

func getJsonFromUrl(){
    let url = NSURL(string: URL)
    URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
        if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
            if let id = jsonObj!.value(forKey: "id_subquestionnair") as? String {
                id_questionario = id
            }
            if let des = jsonObj!.value(forKey: "description") as? String {
                descripcion = des
            }
            if let cantidad = jsonObj!.value(forKey: "cantidad_preguntas") as? String {
                cantidad_preguntas = Int(cantidad) ?? 0
            }
            if let jsonArray = jsonObj!.value(forKey: "preguntas") as? NSArray {
                for subj in jsonArray{
                    if let subjDict = subj as? NSDictionary {
                        if let pregunta = subjDict.value(forKey: "premise") {
                            preguntas.append((pregunta as? String)!)
                        }
                    }
                    if let subjDict = subj as? NSDictionary {
                        if let id = subjDict.value(forKey: "id_question") {
                            id_preg.append((id as? String)!)
                        }
                    }
                    if let subjDict = subj as? NSDictionary {
                        if let tipo = subjDict.value(forKey: "id_type") {
                            tipo_preg.append((tipo as? String)!)
                        }
                    }
                    if let subjDict = subj as? NSDictionary {
                        if let val = subjDict.value(forKey: "max_val") {
                            max_values.append((val as? String)!)
                        }
                    }
                    if let subjDict = subj as? NSDictionary {
                        if let mx_txt = subjDict.value(forKey: "max_text") {
                            max_text.append((mx_txt as? String)!)
                        }
                    }
                    if let subjDict = subj as? NSDictionary {
                        if let mn_txt = subjDict.value(forKey: "min_text") {
                            min_text.append((mn_txt as? String)!)
                        }
                    }
                }
            }
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            print("response = \(String(describing: response))")
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString))")
            response_survey = responseString! as String
            
        }
    }).resume()
}

func sendJson(){

    let request = NSMutableURLRequest(url: NSURL(string: "http://emaapp.online/parseAnswers.php")! as URL)
    request.httpMethod = "POST"
    let postString = "data=\(jsonString)"
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

func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

func limpiarJson()->Dictionary<String, Any>{
    var data = [String:Any]()
    n_jsonDict["token"]=String(token)
    n_jsonDict["os"]="ios"
    let resultados_encuestas = jsonDict["results"] as! [[String:Any]]
    for i in 1...cantidad_preguntas{
        if let resultado_pregunta = resultados_encuestas[i-1]["results"] as? [[String:Any]],
            var resultado = resultado_pregunta.first {
            data["startDate"] = resultado["startDate"]
            data["identifier"] = resultado["identifier"]
            data["questionType"] = resultado["questionType"]
            data["choiceAnswers"] = resultado["choiceAnswers"]
            data["endDate"] = resultado["endDate"]
        }
        n_jsonDict["pregunta"+String(i)+"resultados"] = data
    }
    n_jsonDict["id_subquestionnair"]=jsonDict["identifier"]
    
    return n_jsonDict
}

class EncuestaViewController: UIViewController {
    @IBAction func tomar_encuesta(_ sender: UIButton) {
        getJsonFromUrl()
        if response_survey == "Error: NoHay"{
            let alertTitle = NSLocalizedString("No Survey", comment: "")
            let alertMessage = NSLocalizedString("There is no survey available right now. Please check later.", comment: "")
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let taskViewController = ORKTaskViewController(task: EncuestaMarle, taskRun: nil)
            taskViewController.delegate = (self as ORKTaskViewControllerDelegate)
            present(taskViewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension EncuestaViewController: ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        switch reason {
        case .completed:
            let taskResult_encuesta = taskViewController.result
            
            //Convertir los resultados a un json
            let jsonData = try! ORKESerializer.jsonData(for: taskResult_encuesta)
            //Convertir la data del json a un string
            jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
            jsonString = jsonString.replacingOccurrences(of: "\"isPreviousResult\":false,", with: "")
            jsonString = jsonString.replacingOccurrences(of: "\"_class\":\"ORKStepResult\",", with: "")
            jsonString = jsonString.replacingOccurrences(of: "\"_class\":\"ORKTaskResult\",", with: "")
            jsonString = jsonString.replacingOccurrences(of: "\"_class\":\"ORKTaskResult\",", with: "")
            jsonString = jsonString.replacingOccurrences(of: "\"_class\":\"ORKChoiceQuestionResult\",", with: "")
            jsonDict = convertToDictionary(text: jsonString as String) as! [String: Any]
            let result = limpiarJson()
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
                jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
            }
            catch {
                print(error.localizedDescription)
            }
            sendJson()
        case .failed, .discarded, .saved:
            break
        }
        //Handle results with taskViewController.result
        taskViewController.dismiss(animated: true, completion: nil)
    }
}
