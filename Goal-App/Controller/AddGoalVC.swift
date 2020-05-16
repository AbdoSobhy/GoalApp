//
//  AddGoalVC.swift
//  Goal-App
//
//  Created by Abdelrahman Sobhy on 5/7/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import UIKit
import RealmSwift

class AddGoalVC: UIViewController {
    private var goal = Goal()
    @IBOutlet weak var goalTargetTF: UITextField!
    @IBOutlet weak var goalType: UISegmentedControl!
    @IBOutlet weak var goalTitleTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        addData()
        let relm = try! Realm()
        try! relm.write {
            relm.add(goal)
        }
        goals.append(goal)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func addData(){
        self.goal.title = self.goalTitleTF.text ?? " "
        self.goal.target = Int(self.goalTargetTF.text ?? " ") ?? 0
        switch goalType.selectedSegmentIndex {
        case 0:
            self.goal.type  = "Long Term"
        case 1:
            self.goal.type  = "Short Term"
        default:
            self.goal.type  = " "
        }
    }
    
}
extension AddGoalVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
