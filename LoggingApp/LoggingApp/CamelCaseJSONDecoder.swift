//
//  CamelCaseJSONDecoder.swift
//  LeagueStats
//
//  Created by Geart Otten on 6/4/19.
//  Copyright © 2019 Geart Otten. All rights reserved.
//

import UIKit

extension JSONDecoder {
    
    /// Instantiates a JSON decoder which converts snake-case keys to camel-case keys.
    internal static let camelCaseJSONDecoder: JSONDecoder = {
        let camelCaseJSONDecoder = JSONDecoder()
        camelCaseJSONDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return camelCaseJSONDecoder
    }()
}
