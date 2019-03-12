//
//  SettingsViewController.swift
//  iThirveApp
//
//  Created by JJ SchraderBachar on 12/11/18.
//  Copyright © 2018 JJ SchraderBachar. All rights reserved.
//

import Foundation
import UIKit
class SettingsViewConrtoller: UIViewController {

    @IBAction func logout(_ sender: Any) {
        print("f")
      //UserDefaults.standard.removeObject(forKey: "savedGoals")
        //UserDefaults.standard.removeObject(forKey: "dateG")
        
        //performSegue(withIdentifier: "123", sender: self)
    }
    override func viewWillAppear(_ animated: Bool) {
           self.view.backgroundColor = UIColor(red: 112/255, green: 53/255, blue: 105/255, alpha: 1.00)
    }
 
    
    
}
