//
//  Date.swift
//  LoggingApp
//
//  Created by Geart Otten on 03/01/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//

import Foundation
extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
