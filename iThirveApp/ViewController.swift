//
//  ViewController.swift
//  iThirveApp
//
//  Created by JJ SchraderBachar on 10/31/18.
//  Copyright © 2018 JJ SchraderBachar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // Do  any additional setup after loading the view, typically from a nib.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        print("test")
        let prefs:UserDefaults = UserDefaults.standard
        if let g = UserDefaults.standard.string(forKey: "appKey"){
            Global.global.appKey = g
            print("test")
            performSegue(withIdentifier: "home", sender: self)
           
            self.navigationController?.navigationBar.backgroundColor = self.view.backgroundColor!
            self.navigationController?.navigationBar.barTintColor = self.view.backgroundColor!
               // self.view.backgroundColor = UIColor(red: 112/255, green: 53/255, blue: 105/255, alpha: 1.00)
            
            
        }
        

    }


}

