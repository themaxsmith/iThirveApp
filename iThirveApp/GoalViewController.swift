//
//  GoalViewController.swift
//  iThirveApp
//
//  Created by JJ SchraderBachar on 11/8/18.
//  Copyright © 2018 JJ SchraderBachar. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import DateTimePicker
import SwiftyJSON
import Alamofire
import SwiftyOnboard
class GoalViewController: UIViewController, DateTimePickerDelegate {
    
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        print(didSelectDate)
        Global.global.endDate = Calendar.current.date(byAdding: .day, value: 31, to: didSelectDate)!.addingTimeInterval(3600)
    }
    override func viewWillAppear(_ animated: Bool) {
        
       
    
    
    }
    @IBOutlet weak var tipGoalMaking: UIButton!
    
    func unlockGoals() {
        chooseDate.setTitle("Set Start Date", for: .normal)
        chooseDate.isHidden = false
        tipGoalMaking.isHidden = false
        StartGoalsBtn.setTitle("Start Goals", for: .normal)
        textTitle.text = "Set your new goals to complete!"
        Global.global.canEdit = true
        Global.global.types = [typesOfGoals(name: "Spirtual", #colorLiteral(red: 0.9458187222, green: 0.7334021926, blue: 0.3021544218, alpha: 1)),typesOfGoals(name: "Financial",#colorLiteral(red: 0.8009896874, green: 0.4788030982, blue: 0.7005690932, alpha: 1)),typesOfGoals(name: "Emotional", #colorLiteral(red: 0.5810223222, green: 0.7761070132, blue: 0.7162308693, alpha: 1)), typesOfGoals(name: "Professional",#colorLiteral(red: 0.9248451591, green: 0.4834753871, blue: 0.3483814597, alpha: 1)), typesOfGoals(name: "Relationship", #colorLiteral(red: 0.5137552023, green: 0.1924897432, blue: 0.3086739182, alpha: 1)), typesOfGoals(name: "Physical",#colorLiteral(red: 0.8689427972, green: 0.2297409177, blue: 0.4471674562, alpha: 1)) ]
    }
    
    @IBAction func TipsForGoalMakingButton(_ sender: Any) {
       // performSegue(withIdentifier: "toTIpsPage", sender: self)
    }
    
   
    @IBOutlet weak var chooseDate: UIButton!
    @IBOutlet weak var textTitle: UILabel!
    
    @IBOutlet weak var StartGoalsBtn: UIButton!
    func enterGoals(){
        Global.global.selectedType = Global.global.types[0]
        Global.global.current = 0
        performSegue(withIdentifier: "set", sender: self)
    }
    @IBAction func startDateBtnClicked(_ sender: Any) {
        
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
            enterGoals()
        }else{
        
        if Global.global.canEdit {
            UserDefaults.standard.set(Global.global.endDate.timeIntervalSince1970.rounded(), forKey: "dateG")
         Global.global.canEdit = false
            
            Global.global.canEdit = false
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound], completionHandler: {didAllow, error in})
            
            if let g = UserDefaults.standard.string(forKey: "savedGoals") {
                loadGoals(g)
            }
            setNot()
            chooseDate.isHidden = true
            tipGoalMaking.isHidden = true
            StartGoalsBtn.setTitle("Finish Session Goals", for: .normal)
            Global.global.canEdit = false
            var x = NSCalendar.current.dateComponents([Calendar.Component.day], from: Date(), to: Global.global.endDate).day
           
            if (x! > 31){
                 textTitle.text =  "\(x!-31) day(s) before goals start"
            }else {
                 textTitle.text =  "\(x!) Days to Go!"
            }
            
            sendToServer()
        }else{
            performSegue(withIdentifier: "assess", sender: self)
        }
    }
    }
    @IBAction func chooseDateBtnClicked(_ sender: Any) {
        let min = Date().addingTimeInterval(-60 * 60 * 24 * 0)
        let max = Date().addingTimeInterval(60 * 60 * 24 * 31)
        let picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
        picker.frame = CGRect(x: 0, y: 100, width: picker.frame.size.width, height: picker.frame.size.height)
        picker.isDatePickerOnly = true
        picker.delegate = self
        picker.show()
    }
    struct goals : Decodable {
        var goal1: String
        var goal2: String
        var goal3: String
        
        init(json: JSON) {
            goal1 = json["goal1"] as! String
             goal2 = json["goal2"] as! String
             goal3 = json["goal3"] as! String
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        print("Test")
        saveGoals()
      //  self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
      //  self.navigationController?.navigationBar.shadowImage = UIImage()
     //   self.navigationController?.navigationBar.isTranslucent = true
     //   self.navigationController?.navigationBar.barTintColor = UIColor.clear
     //   self.navigationController?.navigationBar.backgroundColor = UIColor.clear
     //   self.view.layoutIfNeeded()
       
        if ( Global.global.reset){
             Global.global.reset = false
            unlockGoals()
            
        }
        if (Global.global.current > 5){
            if (Global.global.current == 100){
              // Global.global.endDate = Calendar.current.date(byAdding: .day, value: 31, to: Date())!.addingTimeInterval(3600)
                if (Global.global.canEdit){
                startDateBtnClicked(self)
                }
                Global.global.current = 0
            }
            Global.global.current = 0
            
        }
       
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //self.navigationController?.navigationBar.barTintColor = UIColor.clear
        //self.navigationController?.navigationBar.backgroundColor = UIColor.clear
       // self.navigationController?.navigationBar.shadowImage = nil
      //  self.navigationController?.navigationBar.isTranslucent = true
    }
    
     func saveGoals(){
      
        UserDefaults.standard.set(getGoalString(), forKey: "savedGoals")
    }
    @IBAction func logout(_ sender: Any) {
        let alertController = UIAlertController(title: "Logout", message: "Are you sure logout?", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Logout", style: .default, handler: { _ in print("Foo")
            DispatchQueue.main.async {
            UserDefaults.standard.removeObject(forKey: "savedGoals")
            UserDefaults.standard.removeObject(forKey: "dateG")
            UserDefaults.standard.removeObject(forKey: "appKey")
                self.performSegue(withIdentifier: "123", sender: self)
            }
        })
        let OKAction2 = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(OKAction)
         alertController.addAction(OKAction2)
     self.present(alertController, animated: true, completion: nil)
    }
    func getGoalString() -> String {
        var json : JSON = JSON()
        for x in Global.global.types {
            var goals : JSON = [:]
            goals["goal1"] = JSON(x.goal1)
            goals["goal2"] = JSON(x.goal2)
            goals["goal3"] = JSON(x.goal3)
            
            json[x.name] = JSON(goals)
        }
        print(json.rawString())
        
        return json.rawString()!
    }
    func loadGoals(_ data:String ){
        
            let savedGoals:JSON = try! JSON(data:  data.data(using: String.Encoding.utf8)!)
        for x in Global.global.types {
           x.goal1 = savedGoals[x.name]["goal1"].string!
        x.goal2 = savedGoals[x.name]["goal2"].string!
            x.goal3 = savedGoals[x.name]["goal3"].string!
        }
        
    }
    func sendToServer(){
        Alamofire.request(("https://api-upload.mygametape.com/apps/ithrive/send.php?key=\(Global.global.appKey  ?? "")&data=\(getGoalString() ?? "")&endDate=\(Global.global.endDate.timeIntervalSince1970.rounded() ?? 0)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!).responseJSON { response in
            debugPrint(response)
            
            if let json = response.result.value {
                print("JSON: \(json)")
                
                let JSON = json as! NSDictionary
                if (JSON["status"] as! String) == "OK"{
                  //  let user = JSON["user"] as! NSDictionary
                    
                    DispatchQueue.main.async { [weak self] in
                        
                    }
                }else{
                    //TODO ADD LOGIN ERROR FOR INCORECT
                    DispatchQueue.main.async { [weak self] in
                        print("inncorect password")
                    }
                }
            }
        }
    
    }
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func getFromServer(){
       
        
        if ( Global.global.data != ""){
            
                    //  let user = JSON["user"] as! NSDictionary
                    
                    DispatchQueue.main.async { [weak self] in
                        let g = Global.global.serverDate as! String
                            print(g)
                            var date = Date(timeIntervalSince1970:TimeInterval(exactly: Int64(g)!)!)
                            if (date.timeIntervalSinceNow.sign == .plus){
                        self!.loadGoals(Global.global.data as! String)
                                Global.global.canEdit = false
                                UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound], completionHandler: {didAllow, error in})
                            
                                Global.global.endDate = date
                                self!.chooseDate.isHidden = true
                                self!.tipGoalMaking.isHidden = true
                                self!.StartGoalsBtn.setTitle("Finish Session Goals", for: .normal)
                                Global.global.canEdit = false
                                var x = NSCalendar.current.dateComponents([Calendar.Component.day], from: Date(), to: Global.global.endDate).day
                                if (x! > 30){
                                    self!.textTitle.text =  "\(x!-30) before goals start"
                                }else {
                                    self!.textTitle.text =  "\(x!) Days to Go!"
                                }
                            }
                        
                    
             
            }
        }
    }
    
    
    let center = UNUserNotificationCenter.current()
    let options: UNAuthorizationOptions = [.alert, .sound, .badge]
    var swiftyOnboard:SwiftyOnboard!
    override func viewDidLoad() {
        super.viewDidLoad()
        //for the walkthrough
       
        
     // gradient()
        if (Global.global.isLoggingIn){
        swiftyOnboard = SwiftyOnboard(frame: view.frame, style: .light)
        view.addSubview(swiftyOnboard)
        swiftyOnboard.dataSource = self
        swiftyOnboard.delegate = self
        }
        
        if let g = UserDefaults.standard.string(forKey: "dateG"){
             print(g)
            var date = Date(timeIntervalSince1970:TimeInterval(exactly: Int64(g)!)!)
            if (date.timeIntervalSinceNow.sign == .plus){
                Global.global.canEdit = false
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound], completionHandler: {didAllow, error in})
                if let g = UserDefaults.standard.string(forKey: "savedGoals") {
        loadGoals(g)
                }
                Global.global.endDate = date
                chooseDate.isHidden = true
                tipGoalMaking.isHidden = true
                StartGoalsBtn.setTitle("Finish Session Goals", for: .normal)
                Global.global.canEdit = false
                var x = NSCalendar.current.dateComponents([Calendar.Component.day], from: Date(), to: Global.global.endDate).day
                if (x! > 31){
                    textTitle.text =  "\(x!-31) day(s) before goals start"
                }else {
                    textTitle.text =  "\(x!) Days to Go!"
                }
                
              
        // Do any additional setup after loading the view, typically from a nib.
            }else{
                performSegue(withIdentifier: "assess", sender: self)
                
            }
        }else{
                needToSetGoals()
        }
        if (Global.global.log){
            getFromServer()
        }
    }
    func needToSetGoals(){
        textTitle.text = "Set New Goals"
        
    }
  
   
   
  
    
    func notify(title:String,text: String, day: Double){
        let content = UNMutableNotificationContent()
        content.title = "Goal Progression"
        content.subtitle = title
        content.body = text
        content.badge = 1
        let date = Date().addingTimeInterval(60 * 60 * 24 * day)
        //let date = Date().addingTimeInterval(5 + day)
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: "iThrive31_day_\(day)", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        //after one week
 

        
    }
    @IBAction func SpiritButton(_ sender: Any) {
        Global.global.selectedType = Global.global.types[0]
        Global.global.current = 0
        performSegue(withIdentifier: "set", sender: self)
    
        
       
        
        
    }
    func setNot(){
        var x = NSCalendar.current.dateComponents([Calendar.Component.day], from: Date(), to: Global.global.endDate).day
        var buffer:Double = Double(x! - 31)
        print("Buffer:")
        print(buffer)
        if (x! > 31){
             notify(title: "Your goals have began!", text: "Start making progress towards your goals", day: buffer)
        }
        notify(title: "It has been 1 day", text: "What progress have you made towards your goals?", day: buffer+1)
        notify(title: "What have you completed?", text: "It has been 10 days", day: buffer+10)
        notify(title: "What have you completed?", text: "It has been 20 days", day: buffer+20)
        notify(title: "You have 24 hours left", text: "How close are you to achieving all your goals?", day: buffer+30)
        notify(title: "Your Goal Cycle Ended!", text: "Self assess your achievement of your goals and set new goals. ", day: buffer+31)
        
    }
    
    @IBAction func financialButton(_ sender: Any) {
        Global.global.selectedType = Global.global.types[1]
        Global.global.current = 1
        performSegue(withIdentifier:"set", sender: self)
        
    }
    @IBAction func emotionalButton(_ sender: Any) {
        Global.global.selectedType = Global.global.types[2]
               Global.global.current = 2
        performSegue(withIdentifier:"set", sender: self)
        
    }
    
    @IBAction func professionalButton(_ sender: Any) {
        Global.global.selectedType = Global.global.types[3]
               Global.global.current = 3
        performSegue(withIdentifier:"set", sender: self)
    }
    
    @IBAction func relationshipButton(_ sender: Any) {
        Global.global.selectedType = Global.global.types[4]
               Global.global.current = 4
        performSegue(withIdentifier:"set", sender: self)
    }
    
    @IBAction func physicalButton(_ sender: Any) {
        Global.global.selectedType = Global.global.types[5]
               Global.global.current = 5
        performSegue(withIdentifier:"set", sender: self)
        
    }
   
    
    
    
   
    let colors:[UIColor] = [#colorLiteral(red: 0.4392156863, green: 0.2078431373, blue: 0.4117647059, alpha: 1),#colorLiteral(red: 0.4392156863, green: 0.2078431373, blue: 0.4117647059, alpha: 1),#colorLiteral(red: 0.4392156863, green: 0.2078431373, blue: 0.4117647059, alpha: 1),#colorLiteral(red: 0.4392156863, green: 0.2078431373, blue: 0.4117647059, alpha: 1)]
    var titleArray: [String] = ["Welcome to ithrive31!","Set goals in different areas of your life for 31 days.","31 days after you set your start date, you self assess your goals.","Why 31? "]
    var subTitleArray: [String] = ["Helping individuals thrive at work and at home","Enter up to 3 goals for the 6 different life areas.","When you have completed your self assessment, click Finish Goal Assessment to reset your goals and enter new ones.", "31 days is a realistic timeframe to set practical and attainable goals. Set your course for a thriving life 31 days at a time!"]
    //array for images for the walkthrough
    var images: [String] = ["256","GoalSettingPageSS","endOfCycleSS","256"]
    var gradiant: CAGradientLayer = {
        //Gradiant for the background view 112, 53, 105
        let white = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.25).cgColor
        let purple = UIColor(red: 112/255, green: 53/255, blue: 105/255, alpha: 0.5).cgColor
        let gradiant = CAGradientLayer()
       gradiant.colors = [purple, white]
        gradiant.startPoint = CGPoint(x: 0.5, y: 0.18)
        return gradiant
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //done button funciton
   
    func gradient() {
        //Add the gradiant to the view:
        self.gradiant.frame = view.bounds
     view.layer.addSublayer(gradiant)
   }
     
    @objc func handleSkip() {
       // swiftyOnboard?.goToPage(index: 3, animated: true)
         swiftyOnboard!.removeFromSuperview()
    }
    
    @objc func handleContinue(sender: UIButton) {
        let index = sender.tag
      //  swiftyOnboard?.goToPage(index: index + 1, animated: true)
        print("index: \(index)")
        if index == 3 {
            //Replace the '2' with the amount of onboarding screens that you have - 1
            //Perform your segue
            
            swiftyOnboard!.removeFromSuperview()
            return
        }
        swiftyOnboard?.goToPage(index: index + 1, animated: true)
        
    }
}
extension GoalViewController: SwiftyOnboardDelegate, SwiftyOnboardDataSource {
    
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        //Number of pages in the onboarding:
        return 4
    }
    
    func swiftyOnboardBackgroundColorFor(_ swiftyOnboard: SwiftyOnboard, atIndex index: Int) -> UIColor? {
        //Return the background color for the page at index:
        return colors[index]
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let view = SwiftyOnboardPage()
        
        //Set the image on the page:
        view.imageView.image = UIImage(named: images[index])
       
        
        //Set the font and color for the labels:
        view.title.font = UIFont(name: "Lato-Heavy", size: 22)
        view.subTitle.font = UIFont(name: "Lato-Regular", size: 14)
        
        //Set the text in the page:
        view.title.text = titleArray[index]
        view.subTitle.text = subTitleArray[index]
        
        //Return the page for the given index:
        return view
    }
    
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = SwiftyOnboardOverlay()
        
        //Setup targets for the buttons on the overlay view:
        overlay.skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        overlay.continueButton.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        
        //Setup for the overlay buttons:
        overlay.continueButton.titleLabel?.font = UIFont(name: "Lato-Bold", size: 16)
        overlay.continueButton.setTitleColor(UIColor.white, for: .normal)
        overlay.skipButton.setTitleColor(UIColor.white, for: .normal)
        overlay.skipButton.titleLabel?.font = UIFont(name: "Lato-Heavy", size: 16)
        
        //Return the overlay view:
        return overlay
    }
    
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let currentPage = round(position)
        overlay.pageControl.currentPage = Int(currentPage)
        print(Int(currentPage))
        overlay.continueButton.tag = Int(position)
    
        if currentPage == 0.0 || currentPage == 1.0 || currentPage == 2.0 || currentPage == 3.0 {
            overlay.continueButton.setTitle("Continue", for: .normal)
            overlay.skipButton.setTitle("Skip", for: .normal)
            overlay.skipButton.isHidden = false
        } else {
            overlay.continueButton.setTitle("Get Started!", for: .normal)
            overlay.skipButton.isHidden = true
        }
    }
}



