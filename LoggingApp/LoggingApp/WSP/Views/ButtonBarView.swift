//
//  ButtonBarView.swift
//  LoggingApp
//
//  Created by Geart Otten on 27/12/2019.
//  Copyright © 2019 Geart Otten. All rights reserved.
//

import UIKit

protocol ButtonBarViewDelegate {
    func nextButtonTapped(_ button: UIButton)
    func previousButtonTapped(_ button: UIButton)
}

class ButtonBarView: View {
    
    var delegate: ButtonBarViewDelegate?
    
    lazy var previousButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .light, scale: .large)
        let previousArrow = UIImage(systemName: "arrow.left.circle.fill", withConfiguration: config)
        button.setImage(previousArrow, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(previousButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .light, scale: .large)
        let nextArrow = UIImage(systemName: "arrow.right.circle.fill", withConfiguration: config)
        button.setImage(nextArrow, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    override func initView() {
        
    }
    
    override func addSubviews() {
        self.addSubview(previousButton)
        self.addSubview(nextButton)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([previousButton.topAnchor.constraint(equalTo: self.topAnchor),
                                     previousButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
        previousButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)])
        
        NSLayoutConstraint.activate([nextButton.topAnchor.constraint(equalTo: self.topAnchor),
                                     nextButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50),
        nextButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    @objc
    func previousButtonTapped(_ button: UIButton) {
        delegate?.previousButtonTapped(button)
    }
    
    @objc
    func nextButtonTapped(_ button: UIButton) {
        delegate?.nextButtonTapped(button)
    }
}
