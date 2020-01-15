//
//  AircraftCollectionViewCell.swift
//  LoggingApp
//
//  Created by Geart Otten on 15/01/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//

import UIKit

class AircraftCollectionViewCell: UICollectionViewCell {
    public lazy var aircraftImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var typeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        return label
    }()
    
    private lazy var serialNumberLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        return label
    }()
    
    var aircraft: AircraftMO? {
        didSet {
            serialNumberLabel.text = aircraft?.serialnumber
            typeLabel.text = aircraft?.type
            aircraftImage.image = UIImage(named: (aircraft?.type!)!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        
        contentView.addSubview(aircraftImage)
        NSLayoutConstraint.activate([
            aircraftImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            aircraftImage.widthAnchor.constraint(equalToConstant: 178),
            aircraftImage.heightAnchor.constraint(equalToConstant: 105),
            aircraftImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ])
        
        contentView.addSubview(typeLabel)
        contentView.addSubview(serialNumberLabel)
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80),
            serialNumberLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 5),
            serialNumberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            serialNumberLabel.trailingAnchor.constraint(equalTo: typeLabel.trailingAnchor)
        ])
        
    }
}
