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
class LoginViewController : UIViewController, GIDSignInUIDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        //Uncomment to automatically sign in the user.
        GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
       
            

        // ...
    }
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func doneButton(_ sender: Any) {
       print("123")
        Alamofire.request("https://api-upload.mygametape.com/apps/ithrive/?email=\(userText.text ?? "")&password=\(passwordText.text  ?? "")").responseJSON { response in
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
                    print("test2 \(Global.global.appKey)")
                    DispatchQueue.main.async { [weak self] in
                        UserDefaults.standard.set(user["appKey"] as! String, forKey: "appKey")
                        Global.global.isLoggingIn = true
                        self?.performSegue(withIdentifier: "goalsPage", sender: self)
                        
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

       
    @IBAction func googleButton(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
        
    }
    
    @IBAction func facebookButton(_ sender: Any) {
    let manager = LoginManager()
        manager.logIn(readPermissions: [.publicProfile, .email], viewController: self, completion: {LoginResult in
        switch LoginResult{
        case .success(let grantedPermissions, let declinedPermissions, let accsessToken) :
            print ("Logged in!")
        default:
            print("default")
        }
        }
            
            
        )
        
        
}

}
