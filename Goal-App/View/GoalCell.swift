//
//  GoalCell.swift
//  Goal-App
//
//  Created by Abdelrahman Sobhy on 5/7/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import UIKit
import RealmSwift

class GoalCell: UITableViewCell {
    @IBOutlet weak var goalTitle: UILabel!
    @IBOutlet weak var goalProgress: UILabel!
    @IBOutlet weak var goalType: UILabel!
    @IBOutlet weak var completeView: UILabel!

    
    var goal: Goal?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configGoalCell(goal : Goal){
        self.goal = goal
        goalTitle.text = goal.title
        goalType.text = goal.type
        goalProgress.text = String(goal.progress)
        
        if goal.progress == goal.target{
            completeView.isHidden = false
        }

    }
    }

