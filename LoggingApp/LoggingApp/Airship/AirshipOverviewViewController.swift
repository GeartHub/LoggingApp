//
//  AirshipOverviewViewController.swift
//  LoggingApp
//
//  Created by Geart Otten on 07/01/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//

import UIKit

class AirshipOverviewViewController: UIViewController {

    private lazy var aircraftView : UITableView = {
        var tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        CoreDataStack.instance.fetchAircrafts()
        view.addSubview(aircraftView)
        aircraftView.register(UINib(nibName: "AircraftTableViewCell", bundle: nil), forCellReuseIdentifier: "AircraftCell")
        setupConstraints()
    }
    internal func setupConstraints() {
        NSLayoutConstraint.activate([aircraftView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                 aircraftView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
                                 aircraftView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
                                 aircraftView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectedAircraft", let destination = segue.destination as? ViewController {
            let aircraft = sender as! AircraftMO
            destination.aircraft = aircraft
        }
    }

}

extension AirshipOverviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CoreDataStack.instance.fetchedAircrafts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AircraftCell", for: indexPath) as! AircraftTableViewCell
        cell.aircraft = CoreDataStack.instance.fetchedAircrafts[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAircraft = CoreDataStack.instance.fetchedAircrafts[indexPath.row]
        performSegue(withIdentifier: "SelectedAircraft", sender: selectedAircraft)
    }
}
