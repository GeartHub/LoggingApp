//
//  View.swift
//  LoggingApp
//
//  Created by Geart Otten on 27/12/2019.
//  Copyright © 2019 Geart Otten. All rights reserved.
//

import UIKit

class View: UIView {
    
    override class internal var requiresConstraintBasedLayout: Bool { return true }
    
    // MARK: - UIView
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        addSubviews()
        setupConstraints()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - To override by subclasses
    
    func initView() { }
    
    func addSubviews() { }
    
    func setupConstraints() { }
}

