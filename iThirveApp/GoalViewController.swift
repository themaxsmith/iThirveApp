//
//  GoalViewController.swift
//  iThirveApp
//
//  Created by JJ SchraderBachar on 11/8/18.
//  Copyright © 2018 JJ SchraderBachar. All rights reserved.
//

import Foundation
import UIKit

class GoalViewController: UIViewController {
    var types:[typesOfGoals] = [typesOfGoals(name: "Spirtual"),typesOfGoals(name: "Other")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func SpiritButton(_ sender: Any) {
        Global.global.selectedType = types[0]
    }
    
}

