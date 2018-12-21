//
//  GroupStarViewController.swift
//  iThirveApp
//
//  Created by JJ SchraderBachar on 12/21/18.
//  Copyright © 2018 JJ SchraderBachar. All rights reserved.
//

import Foundation
import UIKit
class GroupStarViewController: UIViewController {
    
    
    @IBOutlet weak var groupStarLabel: UILabel!
    override func viewDidAppear(_ animated: Bool) {
        
        groupStarLabel.text = Global.global.assessOutput
    }
}
