//
//  WSPTableViewCell.swift
//  LoggingApp
//
//  Created by Geart Otten on 26/12/2019.
//  Copyright © 2019 Geart Otten. All rights reserved.
//

import UIKit

protocol WSPTableViewCellDelegate {
    func yesButtonTapped(_ button: UIButton, _ cell: WSPTableViewCell)
    func noButtonTapped(_ button: UIButton,_ cell: WSPTableViewCell)
}

class WSPTableViewCell: UITableViewCell {

    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    var newQuestion: Bool = true
    var state: FormType = .answered
    var delegate: WSPTableViewCellDelegate?
    var question: QuestionMO? {
        didSet {
            self.questionTitleLabel.text = question?.title
            switch state {
            case .answered:
                guard let answer = question?.options else { return }
                switch answer {
                case true:
                    yesButton.tintColor = .systemBlue
                case false:
                    noButton.tintColor = .systemRed
                }
                print(answer.hashValue)
            case .new:
                break
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func yesButtonTapped(_ sender: Any) {
        noButton.tintColor = .systemGray
        question?.options = true
        delegate?.yesButtonTapped(sender as! UIButton, self)
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        yesButton.tintColor = .systemGray
        question?.options = false
        delegate?.noButtonTapped(sender as! UIButton, self)
    }
}
