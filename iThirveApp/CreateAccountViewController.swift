//
//  LoginViewController.swift
//  iThirveApp
//
//  Created by JJ SchraderBachar on 10/31/18.
//  Copyright © 2018 JJ SchraderBachar. All rights reserved.
//

import Foundation
import UIKit
import FacebookCore
import FacebookLogin
import Alamofire
import GoogleSignIn
class CreateAcountViewController : UIViewController, GIDSignInUIDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        //Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        
 
        
        
        // ...
    }
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    func login(email:String, password:String, type:String) {
        print("123")
        Alamofire.request("https://api.mygametape.com/apps/ithrive/create.php?email=\(type)\(email)&password=\(password)").responseJSON { response in
            debugPrint(response)
            
            if let json = response.result.value {
                print("JSON: \(json)")
                
                let JSON = json as! NSDictionary
                if (JSON["status"] as! String) == "OK"{
                    let user = JSON["user"] as! NSDictionary
                    
                    Global.global.appKey = user["appKey"] as! String
                    Global.global.email = user["email"] as! String
                    Global.global.data = user["data"] as! String
                    Global.global.serverDate = user["date"] as! String
                    Global.global.log = true
                    Global.global.isLoggingIn = true
                    UserDefaults.standard.set(Global.global.appKey, forKey: "appKey")
                    DispatchQueue.main.async { [weak self] in
                        self?.performSegue(withIdentifier: "goalsPage", sender: self)
                    }
                    
                }else{
                    //TODO ADD LOGIN ERROR FOR INCORECT
                    DispatchQueue.main.async { [weak self] in
                        print("inncorect password")
                        self?.error()
                    }
                }
            }
        }
    }
    
    func error(){
        let alertController = UIAlertController(title: "Error", message: "Failed to create account", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
        })
        let OKAction2 = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(OKAction)
    
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func doneButton(_ sender: Any) {
        print("123")
        if !((userText.text?.isEmpty)!) && !((passwordText.text?.isEmpty)!){
        Alamofire.request("https://api-upload.mygametape.com/apps/ithrive/create.php?email=\(userText.text ?? "")&password=\(passwordText.text  ?? "")").responseJSON { response in
            debugPrint(response)
            
            if let json = response.result.value {
                print("JSON: \(json)")
                
                let JSON = json as! NSDictionary
                if (JSON["status"] as! String) == "OK"{
                    let user = JSON["user"] as! NSDictionary
                    
                    Global.global.appKey = user["appKey"] as! String
                    Global.global.email = user["email"] as! String
                    Global.global.data = user["data"] as! String
                    Global.global.serverDate = user["date"] as! String
                    Global.global.log = true
                    Global.global.isLoggingIn = true
                    UserDefaults.standard.set(Global.global.appKey, forKey: "appKey")
                    DispatchQueue.main.async { [weak self] in
                            self?.performSegue(withIdentifier: "goalsPage", sender: self)
                    }
                    
                }else{
                    //TODO ADD LOGIN ERROR FOR INCORECT
                    DispatchQueue.main.async { [weak self] in
                        print("inncorect password")
                                    self?.error()
                    }
                }
            }
        }
        }
    }
    
    
    @IBAction func googleButton(_ sender: Any) {
        GIDSignIn.sharedInstance()!.signIn()
        
        //login(email: Global.global.email, password: Global.global.password, type: "Google")
        
    }
    override func viewWillAppear(_ animated: Bool) {
           self.view.backgroundColor = UIColor(red: 112/255, green: 53/255, blue: 105/255, alpha: 1.00)
    }
    
    @IBAction func facebookButton(_ sender: Any) {
        let manager = LoginManager()
        manager.logIn(readPermissions: [.publicProfile, .email], viewController: self, completion: {LoginResult in
            switch LoginResult{
            case .success(let grantedPermissions, let declinedPermissions, let accsessToken) :
                print ("Logged in!")
                
                let params = ["fields" : "email, name"]
                let graphRequest = GraphRequest(graphPath: "me", parameters: params)
                graphRequest.start {
                    (urlResponse, requestResult) in
                    
                    switch requestResult {
                    case .failed(let error):
                        print("error in graph request:", error)
                        break
                    case .success(let graphResponse):
                        if let responseDictionary = graphResponse.dictionaryValue {
                            print(responseDictionary)
                            
                            print(responseDictionary["name"])
                            print(responseDictionary["email"])
                            self.login(email: responseDictionary["email"] as! String, password: accsessToken.authenticationToken, type: "FB")
                        }
                    }
                }
                
            default:
                print("default")
            }
        }
            
            
        )
        
        
    }
    
}
