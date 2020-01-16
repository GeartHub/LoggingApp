//
//  AircraftOverviewViewController.swift
//  LoggingApp
//
//  Created by Geart Otten on 07/01/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//

import UIKit

class AircraftOverviewViewController: UIViewController {
    
    private var aircraftView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        CoreDataStack.instance.fetchAircrafts()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        aircraftView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        aircraftView.dataSource = self
        aircraftView.delegate = self
        aircraftView.register(AircraftCollectionViewCell.self, forCellWithReuseIdentifier: AircraftCollectionViewCell.reuseIdentifier)
        aircraftView.translatesAutoresizingMaskIntoConstraints = false
        aircraftView.backgroundColor = .white
        view.addSubview(aircraftView)
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

extension AircraftOverviewViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CoreDataStack.instance.fetchedAircrafts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AircraftCollectionViewCell.reuseIdentifier, for: indexPath) as! AircraftCollectionViewCell
        
        cell.aircraft = CoreDataStack.instance.fetchedAircrafts[indexPath.row]
        
        return cell

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAircraft = CoreDataStack.instance.fetchedAircrafts[indexPath.row]
        performSegue(withIdentifier: "SelectedAircraft", sender: selectedAircraft)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: aircraftView.frame.width / 2 - 5, height: 218)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
    }
}
