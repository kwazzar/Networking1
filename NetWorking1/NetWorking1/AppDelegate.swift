//
//  AppDelegate.swift
//  NetWorking1
//
//  Created by Quasar on 18.04.2023.
//

import UIKit
import FBSDKCoreKit

let primaryColor = UIColor(red: 210/255, green: 109/255, blue: 128/255, alpha: 1)
let secondaryColor = UIColor(red: 107/255, green: 148/255, blue: 230/255, alpha: 1)



@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    
    
    // cтейковервфлов хром
    var bgSessionCompletionHandler: (() -> ())?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FBSDKCoreKit.ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

        let bundle = Bundle.main
        let providing = bundle as FBSDKCoreKit_Basics.InfoDictionaryProviding
        let settings = FBSDKCoreKit.Settings.shared
        print(FBSDKCoreKit.Settings.shared.appID as Any)
   // FB_APP_ID: Optional("1314195279448315")
        //client token neeed
//        print("FB_APP_ID:", settings.appID) // -> nil
//        print("FB_PRIVATE_APP_ID:", settings.value(forKey: "_appID")) // -> nil
//        print("INFO_APP_ID:", bundle.infoDictionary?["FacebookAppID"] as Any) // -> MyAwesomeApp
//        print("PROVIDING_APP_ID:", providing.fb_object(forInfoDictionaryKey: "FacebookAppID") as Any) // -> MyAwesomeApp
        
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        ApplicationDelegate.shared.application(
                    app,
                    open: url,
                    sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                    annotation: options[UIApplication.OpenURLOptionsKey.annotation]
                )
        
        let appId = Settings.shared.appID
   
        
        if url.scheme != nil && url.scheme!.hasPrefix("fb\(String(describing: appId))") && url.host == "authorize" {
            
            return ApplicationDelegate.shared.application(app, open: url, options: options)
        }
        return false
        
    }
    
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        
        bgSessionCompletionHandler = completionHandler
    }
}
