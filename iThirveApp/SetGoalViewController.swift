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
    
    @IBOutlet weak var enterUpTo: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var goal1Text: UITextField!
    
    @IBOutlet weak var goal2Text: UITextField!
    
    @IBOutlet weak var goal3Text: UITextField!
    
    @IBOutlet weak var navHeader: UINavigationItem!
    
    override func viewWillAppear(_ animated: Bool) {
       setup()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        Global.global.selectedType?.goal1 = goal1Text.text ?? (Global.global.selectedType?.goal1)!
        Global.global.selectedType?.goal2 = goal2Text.text ?? (Global.global.selectedType?.goal2)!
        Global.global.selectedType?.goal3 = goal3Text.text ?? (Global.global.selectedType?.goal3)!
        
        self.navigationController?.navigationBar.backgroundColor = self.view.backgroundColor!
        self.navigationController?.navigationBar.barTintColor = self.view.backgroundColor!
      
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if (Global.global.current < 5){
            Global.global.selectedType?.goal1 = goal1Text.text ?? (Global.global.selectedType?.goal1)!
            Global.global.selectedType?.goal2 = goal2Text.text ?? (Global.global.selectedType?.goal2)!
            Global.global.selectedType?.goal3 = goal3Text.text ?? (Global.global.selectedType?.goal3)!
            self.navigationController?.navigationBar.backgroundColor = self.view.backgroundColor!
            self.navigationController?.navigationBar.barTintColor = self.view.backgroundColor!
              Global.global.selectedType = Global.global.types[Global.global.current + 1]
        Global.global.current += 1
             setup()
        }
       else{
            //to change the button text
             //continueButton.setTitle("Start goals", for: .normal)
            Global.global.current = 100
            self.navigationController?.popViewController(animated: true)
            //setup()
        }

    }
    @IBOutlet weak var typeOfGoalLabel: UILabel!
    
    @IBAction func assessGoalButton(_ sender: Any) {
      

    }
    func setup(){
        self.view.backgroundColor = UIColor(red: 112/255, green: 53/255, blue: 105/255, alpha: 1.00)
        navHeader.title = Global.global.selectedType?.name
        //typeOfGoalLabel.text = Global.global.selectedType?.name
        goal1Text.text = Global.global.selectedType?.goal1
        goal2Text.text = Global.global.selectedType?.goal2
        goal3Text.text = Global.global.selectedType?.goal3
        
        goal1Text.isHidden = false
        goal2Text.isHidden = false
        goal3Text.isHidden = false
        if !(Global.global.canEdit){
            goal1Text.isEnabled = false
            goal2Text.isEnabled = false
            goal3Text.isEnabled = false
            
            enterUpTo.text = "(Current Goals)"
            
            if (Global.global.selectedType?.goal1.isEmpty)! {
                 goal1Text.placeholder = "No Goal Set"
            }
            if (Global.global.selectedType?.goal2.isEmpty)! {
                goal2Text.placeholder = "No Goal Set"
            }
            if (Global.global.selectedType?.goal3.isEmpty)! {
                goal3Text.placeholder = "No Goal Set"
            }
            
        }else{
            goal1Text.isEnabled = true
            goal2Text.isEnabled = true
            goal3Text.isEnabled = true
            

             enterUpTo.text = "(Enter up to 3 goals)"
        }
        if (Global.global.current == 5){
            if Global.global.canEdit{
            continueButton.setTitle("Start Your Goals", for: .normal)
            }else{
                continueButton.setTitle("Close Goals", for: .normal)
            }
        }
        navHeader.titleView?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationController?.navigationBar.backgroundColor = Global.global.selectedType?.color
        
        self.navigationController?.navigationBar.barTintColor = Global.global.selectedType?.color
        let app = UINavigationBar.appearance()
        // nav bar color => your color
        
        //app.barTintColor =  Global.global.selectedType?.color
        app.isTranslucent = false
        // status bar text => white
        app.barStyle = .black
        app.isOpaque = true
        // nav bar elements color => white
        app.tintColor = .white
        app.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        if (Global.global.current == 5){
         
        }
    }
}

