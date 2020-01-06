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
