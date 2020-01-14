//
//  FormModels.swift
//  LoggingApp
//
//  Created by Geart Otten on 17/12/2019.
//  Copyright © 2019 Geart Otten. All rights reserved.
//

import Foundation

struct Forms: Codable {
    let steps: [Step]
}

struct Step: Codable {
    let title: String
    let questionTitles: [String]
}

enum FormType {
    case new
    case answered
}

class FormTemplate {
    private var isMadeInCoreData = false
    var form: FormMO?
    let context = CoreDataStack.instance.managedObjectContext
    var type: FormType?
    
    init(formType: FormType, form: FormMO? = nil) {
        self.type = formType
        switch formType {
        case .new:
            generateForm()
        case .answered:
            guard let form = form else { return }
            self.form = form
        }
    }
    
    
    private func generateForm() {
        let newForm = FormMO(context: context)
        newForm.createdAt = Date()
        
        if let path = Bundle.main.path(forResource: "wsp", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let form = try? JSONDecoder.camelCaseJSONDecoder.decode(Forms.self, from: jsonData)
                if let form = form {
                    for (numberOfStep, step) in form.steps.enumerated() {
                        let stepInLogbookItem = StepMO(context: context)
                        stepInLogbookItem.title = step.title
                        stepInLogbookItem.order = Double(numberOfStep)
                        for (numberOfQuestion, question) in step.questionTitles.enumerated() {
                            let questionInStep = QuestionMO(context: context)
                            questionInStep.order = Double(numberOfQuestion)
                            questionInStep.title = question
                            questionInStep.addToStep(stepInLogbookItem)
                        }
                        stepInLogbookItem.addToForm(newForm)
                    }
                    self.form = newForm
                }
                
            } catch {
                debugPrint(error)
            }
        }
    }
}
