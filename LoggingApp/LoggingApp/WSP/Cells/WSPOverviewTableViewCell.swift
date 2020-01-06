//
//  WSPOverviewTableViewCell.swift
//  LoggingApp
//
//  Created by Geart Otten on 03/01/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//

import UIKit

class WSPOverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createAtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
