//
//  SetGoalViewController.swift
//  iThirveApp
//
//  Created by JJ SchraderBachar on 11/8/18.
//  Copyright © 2018 JJ SchraderBachar. All rights reserved.
//

import Foundation
import UIKit
class SetGoalViewController: UIViewController{
    
    @IBOutlet weak var goal1Text: UITextField!
    
    @IBOutlet weak var goal2Text: UITextField!
    
    @IBOutlet weak var goal3Text: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        typeOfGoalLabel.text = Global.global.selectedType?.name
        goal1Text.text = Global.global.selectedType?.goal1
        goal2Text.text = Global.global.selectedType?.goal2
        goal3Text.text = Global.global.selectedType?.goal3
        if !(Global.global.canEdit){
            goal1Text.isEnabled = false
            goal2Text.isEnabled = false
            goal3Text.isEnabled = false
        }else{
            goal1Text.isEnabled = true
            goal2Text.isEnabled = true
            goal3Text.isEnabled = true
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        Global.global.selectedType?.goal1 = goal1Text.text ?? (Global.global.selectedType?.goal1)!
        Global.global.selectedType?.goal2 = goal2Text.text ?? (Global.global.selectedType?.goal2)!
        Global.global.selectedType?.goal3 = goal3Text.text ?? (Global.global.selectedType?.goal3)!
    }
    
    @IBOutlet weak var typeOfGoalLabel: UILabel!
    
    @IBAction func assessGoalButton(_ sender: Any) {
      

    }
}

