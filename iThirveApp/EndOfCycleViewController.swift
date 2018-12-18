//
//  EndOfCycleViewController.swift
//  iThirveApp
//
//  Created by JJ SchraderBachar on 11/16/18.
//  Copyright © 2018 JJ SchraderBachar. All rights reserved.
//

import Foundation
import UIKit
import Cosmos
class EndOfCycleViewConrtoller: UIViewController {
   override func viewDidLayoutSubviews() {
        var width = self.view.frame.width
        var size = 0
        var text:[String] = []
        for x in Global.global.types{
            if (x.goal1 != ""){
                size = size + 1
                text.append(x.goal1)
            }
            if (x.goal2 != ""){
                size = size + 1
                text.append(x.goal2)
            }
            if (x.goal3 != ""){
                size = size + 1
                text.append(x.goal3)
            }
        }
        if size == 0 {
            
        }else{
         
            
          scroll.scrollRectToVisible(CGRect(x: 0, y: 0, width: scroll.frame.width, height: CGFloat(size * 25)), animated: true)
            for x in 0...size-1 {
                let label = UILabel(frame: CGRect(x: 0, y: x * 50, width: Int(width-180), height: 25))
                
                label.textAlignment = .left
                label.text = text[x]
                scroll.addSubview(label)
                var customView = CosmosView(frame: CGRect(x: Int(width-200), y: x * 50, width: 200, height: 25))
                stars.append(customView)
                scroll.addSubview(customView)
                
            }
            scroll.contentSize = scroll.frame.size //sets ScrollView content

            
        }
    }
    @IBOutlet weak var scroll: UIScrollView!
    var stars:[CosmosView] = []
    override func viewDidLoad() {
      scroll.isScrollEnabled = true
        scroll.contentSize.height = 1800
      
    }
    
    @IBAction func GoalFinish(_ sender: Any) {
        for x in stars {
            print(x.rating)
        }
        print("output")
         UserDefaults.standard.set(Global.global.endDate?.timeIntervalSince1970.rounded(), forKey: "dateG")
        UserDefaults.standard.removeObject(forKey: "dateG")
        UserDefaults.standard.removeObject(forKey: "savedGoals")
        Global.global.reset = true
        Global.global.types = [typesOfGoals(name: "Spirtual"),typesOfGoals(name: "Financial"),typesOfGoals(name: "Emotional"), typesOfGoals(name: "Professional"), typesOfGoals(name: "Relationship"), typesOfGoals(name: "Physical") ]
       self.navigationController!.popViewController(animated: true)
    }
    
}
