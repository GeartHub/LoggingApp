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
    func addParticularityButtonTapped(_ button: UIButton, _ cell: WSPTableViewCell)
}

class WSPTableViewCell: UITableViewCell {

    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var addParticularityButton: UIButton!
    @IBOutlet weak var particularityView: UIView!
    @IBOutlet weak var particularitiesLabel: UILabel!
    @IBOutlet weak var particularityHeightConstraint: NSLayoutConstraint!
    var isAnimated: Bool = false
    
    var newQuestion: Bool = true
    var delegate: WSPTableViewCellDelegate?
    var question: QuestionMO? {
        didSet {
            self.questionTitleLabel.text = question?.title
            guard let answer = question?.options else { return }
            switch answer {
            case 2:
                yesButton.tintColor = .systemBlue
            case 1:
                noButton.tintColor = .systemRed
            default:
                noButton.tintColor = .systemGray
                yesButton.tintColor = .systemGray
                addParticularityButton.tintColor = .systemGray
                let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .light, scale: .large)
                let filledPen = UIImage(systemName: "pencil.circle", withConfiguration: config)
                self.addParticularityButton.setImage(filledPen, for: .normal)
            }
            if let particularity = question?.particularities {
                particularitiesLabel.text = "Opmerkingen: \(particularity)"
                let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .light, scale: .large)
                let filledPen = UIImage(systemName: "pencil.circle.fill", withConfiguration: config)
                addParticularityButton.setImage(filledPen, for: .normal)
                addParticularityButton.tintColor = .systemBlue
            } else if question?.particularities == nil {
                particularityHeightConstraint.constant = 0
                particularityView.updateConstraints()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func yesButtonTapped(_ sender: Any) {
        noButton.tintColor = .systemGray
        question?.options = 2
        delegate?.yesButtonTapped(sender as! UIButton, self)
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        yesButton.tintColor = .systemGray
        question?.options = 1
        delegate?.noButtonTapped(sender as! UIButton, self)
    }
    @IBAction func addParticularityButtonTapped(_ sender: Any) {
        delegate?.addParticularityButtonTapped(sender as! UIButton, self)
    }
    
}
