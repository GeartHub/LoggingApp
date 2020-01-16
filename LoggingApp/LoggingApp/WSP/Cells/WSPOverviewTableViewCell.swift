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
    @IBOutlet weak var cellContent: UIView!
    
    var form: FormMO? {
        didSet {
            titleLabel.text = form?.title
            createAtLabel.text = form?.createdAt?.toString(dateFormat: "dd-MM-yyyy HH:mm")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.cellContent.layer.cornerRadius = 8
        self.cellContent.clipsToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1;
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
