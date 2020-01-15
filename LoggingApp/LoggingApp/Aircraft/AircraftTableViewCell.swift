//
//  AircraftTableViewCell.swift
//  LoggingApp
//
//  Created by Geart Otten on 07/01/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//

import UIKit

class AircraftTableViewCell: UITableViewCell {

    var aircraft: AircraftMO? {
        didSet {
            serialNumberLabel.text = aircraft?.serialnumber
            typeLabel.text = aircraft?.type
        }
    }
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
