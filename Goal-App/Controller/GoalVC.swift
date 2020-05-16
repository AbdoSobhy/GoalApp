//
//  ViewController.swift
//  Goal-App
//
//  Created by Abdelrahman Sobhy on 5/7/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import UIKit
import RealmSwift
var goals = [Goal]()
class GoalVC: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
    
    @IBOutlet weak var goalTable: UITableView!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ralmObej = realm.objects(Goal.self)
        for goal in ralmObej{
            goals.append(goal)

        }
        self.goalTable.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        goalTable.reloadData()
    }
    
    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        guard let addGoalVC = storyboard?.instantiateViewController(withIdentifier: "AddGoalVC") as? AddGoalVC else {return}
        addGoalVC.modalPresentationStyle = .fullScreen
//        addGoalVC.presentationController?.delegate = self
        present(addGoalVC,animated: true,completion: nil)
        
    }
}

//extension GoalVC: UIAdaptivePresentationControllerDelegate {
//    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
//print("here")
//
//    }
//}

extension GoalVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell", for: indexPath) as? GoalCell else {return UITableViewCell()}
        cell.configGoalCell(goal: goals[indexPath.row])
        return cell
    }
}

extension GoalVC :  UITableViewDelegate{
    
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteBtn = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            
            try! self.realm.write { self.realm.delete(goals[indexPath.row]) }
            goals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.goalTable.reloadData()
        }
        let addBtn = UIContextualAction(style: .normal, title: "Add") { (action, view, compleation) in
            
            let cell = tableView.cellForRow(at: indexPath) as! GoalCell

            try! self.realm.write {
                if cell.goal!.progress < cell.goal!.target{
                    cell.goal!.progress += 1
                    if cell.goal!.progress == cell.goal!.target{
                        cell.completeView.isHidden = false
                        tableView.reloadRows(at: [indexPath], with: .fade)
                    }
                }  else {return}
            }
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        addBtn.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        return .init(actions: [deleteBtn,addBtn])
    }
    
}
