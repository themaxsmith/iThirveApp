//
//  AppDelegate.swift
//  iThirveApp
//
//  Created by JJ SchraderBachar on 10/31/18.
//  Copyright © 2018 JJ SchraderBachar. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import IQKeyboardManagerSwift
import GoogleSignIn
import UserNotifications
import Cosmos
import Alamofire
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate{
   
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
               UserDefaults.standard.set(Global.global.appKey, forKey: "appKey")
            Global.global.email = email ?? ""
            Global.global.password = idToken ?? ""
            login(email: Global.global.email, password: Global.global.password, type: "Google")
            
          
         
        }
    }
    var window: UIWindow?
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url as URL?,
                                                 sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplication.OpenURLOptionsKey.annotation])
  
    }
   

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.isStatusBarHidden = false
        
        UIApplication.shared.statusBarStyle = .lightContent
        // Override point for customization after application launch.
        UINavigationBar.appearance().setBackgroundImage(
            UIImage(),
            for: .any,
            barMetrics: .default)
        
        UINavigationBar.appearance().shadowImage = UIImage()
        GIDSignIn.sharedInstance().clientID = "554884841165-nc2mpi1ug1u646f01fg4eu2i33gmmr3o.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        IQKeyboardManager.shared.enable = true
        
        return true
    }
    
   

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    

    class func sharedInstance() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
 
    func login(email:String, password:String, type:String) {
     print("google signin 2")
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
                       self?.window?.visibleViewController()?.performSegue(withIdentifier: "goalsPage", sender: nil)
                    }
                    
                }else{
                    //TODO ADD LOGIN ERROR FOR INCORECT
                    DispatchQueue.main.async { [weak self] in
                        self?.window?.visibleViewController()?.performSegue(withIdentifier: "goalsPage", sender: nil)
                    }
                }
            }
        }
    }
    
}

extension UIWindow {
    
    func visibleViewController() -> UIViewController? {
        if let rootViewController: UIViewController = self.rootViewController {
            return UIWindow.getVisibleViewControllerFrom(vc: rootViewController)
        }
        return nil
    }
    
    static func getVisibleViewControllerFrom(vc:UIViewController) -> UIViewController {
        if let navigationController = vc as? UINavigationController,
            let visibleController = navigationController.visibleViewController  {
            return UIWindow.getVisibleViewControllerFrom( vc: visibleController )
        } else if let tabBarController = vc as? UITabBarController,
            let selectedTabController = tabBarController.selectedViewController {
            return UIWindow.getVisibleViewControllerFrom(vc: selectedTabController )
        } else {
            if let presentedViewController = vc.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(vc: presentedViewController)
            } else {
                return vc
            }
        }
    }
}
