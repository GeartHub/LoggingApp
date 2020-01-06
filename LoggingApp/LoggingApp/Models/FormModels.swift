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
    private var type: FormType?
    var form: FormMO?
    
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
        if let path = Bundle.main.path(forResource: "wsp", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let form = try? JSONDecoder.camelCaseJSONDecoder.decode(Forms.self, from: jsonData)
                if let form = form {
                    
                }
                
            } catch {
                debugPrint(error)
            }
        }
    }
}
