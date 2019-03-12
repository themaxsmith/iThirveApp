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
import UserNotifications
class EndOfCycleViewConrtoller: UIViewController {
   override func viewDidLayoutSubviews() {
    
    }
    
    func create(){
        
        var size = 0
        var text:[String] = []
        for x in Global.global.types{
            if (x.goal1 != ""){
                size = size + 1
                text.append(x.goal1)
                print("add 1 "+x.name)
            }
            if (x.goal2 != ""){
                size = size + 1
                text.append(x.goal2)
                print("add 2"+x.name)
            }
            if (x.goal3 != ""){
                size = size + 1
                text.append(x.goal3)
                print("add 3"+x.name)
            }
        }
        if size == 0 {
            
        }else{
            
            //var width = scroll.frame.width
            var width = self.view.frame.width
            scroll.scrollRectToVisible(CGRect(x: 0, y: 0, width: scroll.frame.width, height: CGFloat(size * 50) + 2000), animated: true)
            for x in 0...size-1 {
                print(text[x] + " out")
                let label = UILabel(frame: CGRect(x: 10, y: (x * 50) + 10, width: Int(width-140), height: 25))
                
                label.textAlignment = .left
                label.text = text[x]
                label.textColor = UIColor.white
                
                scroll.addSubview(label)
                var customView = CosmosView(frame: CGRect(x: Int(width-120), y: (x * 50) + 10, width: 200, height: 25))
                customView.rating = 0
                stars.append(customView)
                scroll.addSubview(customView)
                
            }
            scroll.addSubview(UIView(frame: CGRect(x: Int(width-120), y: (size*50) + 10, width: 200, height: 6000)))
           
            
          scroll.updateContentView()
            scroll.layoutIfNeeded()
            view.layoutIfNeeded()
            
        }
    }
    @IBOutlet weak var scroll: UIScrollView!
    var stars:[CosmosView] = []
    override func viewDidLoad() {
      scroll.isScrollEnabled = true
        scroll.contentSize.height = 4000
      
    }
    
    @IBAction func GoalFinish(_ sender: Any) {
        Global.global.assessOutput = ""
        var rating:[Int] = [0,0,0,0,0,0]
     
        for x in stars {
            print(x.rating)
            rating[Int(x.rating)] = rating[Int(x.rating)] + 1
            
        }
       
        if rating[0] > 0 {
            
            Global.global.assessOutput += "You have \(rating[0]) zero star rating(s)\n"
        }
        if rating[1] > 0 {
            Global.global.assessOutput += "You have \(rating[1]) one star rating(s)\n"
        }
        if rating[2] > 0 {
            Global.global.assessOutput += "You have \(rating[2]) two star rating(s)\n"
        }
        if rating[3] > 0 {
            Global.global.assessOutput += "You have \(rating[3]) three star rating(s)\n"
        }
                if rating[4] > 0 {
            Global.global.assessOutput += "You have \(rating[4]) four star rating(s)\n"
        }
        if rating[5] > 0 {
            
            Global.global.assessOutput += "You have \(rating[5]) five star rating(s)\n"
        }

       
        
        
       
        
        print("output")
        UserDefaults.standard.set(Global.global.endDate.timeIntervalSince1970.rounded(), forKey: "dateG")
        UserDefaults.standard.removeObject(forKey: "dateG")
        UserDefaults.standard.removeObject(forKey: "savedGoals")
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        Global.global.reset = true
        Global.global.types = [typesOfGoals(name: "Spirtual", #colorLiteral(red: 0.9458187222, green: 0.7334021926, blue: 0.3021544218, alpha: 1)),typesOfGoals(name: "Financial",#colorLiteral(red: 0.8009896874, green: 0.4788030982, blue: 0.7005690932, alpha: 1)),typesOfGoals(name: "Emotional", #colorLiteral(red: 0.5810223222, green: 0.7761070132, blue: 0.7162308693, alpha: 1)), typesOfGoals(name: "Professional",#colorLiteral(red: 0.9248451591, green: 0.4834753871, blue: 0.3483814597, alpha: 1)), typesOfGoals(name: "Relationship", #colorLiteral(red: 0.5137552023, green: 0.1924897432, blue: 0.3086739182, alpha: 1)), typesOfGoals(name: "Physical",#colorLiteral(red: 0.8689427972, green: 0.2297409177, blue: 0.4471674562, alpha: 1)) ]
       self.performSegue(withIdentifier: "groupStar", sender: self)
    }
    override func viewWillAppear(_ animated: Bool) {
           self.view.backgroundColor = UIColor(red: 112/255, green: 53/255, blue: 105/255, alpha: 1.00)
        create()
    }
    
}
extension UIScrollView {
    func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
    }
}
