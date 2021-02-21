//
//  ClassCell.swift
//  SolveIt.Test
//
//  Created by Pavel Tsiareschcanka on 21.02.21.
//

import UIKit

class LessonCell: UITableViewCell {
    
    //MARK:- Outlets
    
    @IBOutlet private weak var containerView: UIView!
    
    @IBOutlet private weak var backgroundImageView: UIImageView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var lastUpdateLabel: UILabel!
    
    @IBOutlet private weak var statusContainerView: UIView!
    @IBOutlet private weak var statusLabel: UILabel!
    
    @IBOutlet private weak var someActionButton: UIButton!
    
    //MARK:- Public Properties
    
    var data: Lesson? {
        didSet {
            updateUI()
        }
    }
    
    //MARK:- Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    //MARK:- Private functions
    
    private func setupUI() {
        
        selectionStyle = .none
        
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 6
        
        statusContainerView.layer.cornerRadius = 4
    }
    
    private func updateUI() {
        guard let data = self.data else { return }
        
        nameLabel.text = data.name
        statusLabel.text = TitlesConverter.getStatusTitleFrom(data.status)
        lastUpdateLabel.text = TitlesConverter.getTimeTitleFrom(data.updateAt)
        
        switch data.status {
        case "inProgress":
            
            someActionButton.isHidden = false
            statusContainerView.backgroundColor = .lessonsListInProgress
        case "completed":
            
            someActionButton.isHidden = true
            statusContainerView.backgroundColor = .lessonsListCompleted
        case "notStarted":
            
            someActionButton.isHidden = false
            statusContainerView.backgroundColor = .lessonsListStart
        default:
            someActionButton.isHidden = true
            statusContainerView.backgroundColor = .lessonsListStart
            
        }
        
        switch data.type {
        
//        case "physics": backgroundImageView.image = UIImage(named: "LessonsList_Physics")
        case "physics": backgroundImageView.image = UIImage(named: "LessonsList_Chemistry")
        case "chemistry": backgroundImageView.image = UIImage(named: "LessonsList_Chemistry")
//        case "science", "math": backgroundImageView.image = UIImage(named: "LessonsList_MathAndScience")
        case "science", "math": backgroundImageView.image = UIImage(named: "LessonsList_English")
        case "english": backgroundImageView.image = UIImage(named: "LessonsList_English")
        default: backgroundImageView.image = UIImage(named: "")
        }
    }
}
