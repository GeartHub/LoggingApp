//
//  AddParticularitiesViewController.swift
//  LoggingApp
//
//  Created by Geart Otten on 11/01/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//

import UIKit

protocol AddParticularitiesViewControllerDelegate {
    func doneButtonTapped(_ sender: Any)
}

class AddParticularitiesViewController: UIViewController {

    @IBOutlet weak var particularityTextField: UITextField!
    var delegate: AddParticularitiesViewControllerDelegate?
    var question: QuestionMO?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        particularityTextField.becomeFirstResponder()
        guard let particularities = question?.particularities else { return }
        particularityTextField.text = particularities
        
    }
    @IBAction func doneButtonTapped(_ sender: Any) {
        if particularityTextField.text?.count ?? 0 > 1 {
            question?.particularities = particularityTextField.text
        }
        
        delegate?.doneButtonTapped(self)
        self.dismiss(animated: true, completion: nil)
    }
}
