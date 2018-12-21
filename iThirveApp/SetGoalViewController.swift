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
    
    @IBOutlet weak var navHeader: UINavigationItem!
    
    override func viewWillAppear(_ animated: Bool) {
           self.view.backgroundColor = UIColor(red: 112/255, green: 53/255, blue: 105/255, alpha: 1.00)
        navHeader.title = Global.global.selectedType?.name
        //typeOfGoalLabel.text = Global.global.selectedType?.name
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
        navHeader.titleView?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationController?.navigationBar.backgroundColor = Global.global.selectedType?.color
        
        self.navigationController?.navigationBar.barTintColor = Global.global.selectedType?.color
        let app = UINavigationBar.appearance()
        // nav bar color => your color
    
        app.barTintColor =  Global.global.selectedType?.color
        app.isTranslucent = false
        // status bar text => white
        app.barStyle = .black
        app.isOpaque = true
        // nav bar elements color => white
        app.tintColor = .white
        app.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
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

