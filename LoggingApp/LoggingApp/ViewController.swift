//
//  ViewController.swift
//  LoggingApp
//
//  Created by Geart Otten on 09/12/2019.
//  Copyright © 2019 Geart Otten. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var aircraft: AircraftMO?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateNewWSPSegue", let destination = segue.destination as? WSPViewController {
            destination.aircraft = aircraft
        } else if segue.identifier == "ShowWSPSegue", let destination = segue.destination as? WSPOverviewViewController {
            destination.aircraft = aircraft
        }
    }
}

