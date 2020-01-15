//
//  UIViewControllerExtensions.swift
//  LoggingApp
//
//  Created by Geart Otten on 15/01/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//

// Put this piece of code anywhere you like
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
