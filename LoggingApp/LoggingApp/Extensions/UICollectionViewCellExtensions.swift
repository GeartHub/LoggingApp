//
//  UICollectionViewCellExtensions.swift
//  LoggingApp
//
//  Created by Geart Otten on 15/01/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    /// Returns the reuseidentifier of a cell
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

