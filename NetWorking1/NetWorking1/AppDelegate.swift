//
//  AppDelegate.swift
//  NetWorking1
//
//  Created by Quasar on 18.04.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var bgSessionCompletionHandler: (() -> ())?
    
 
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        
        bgSessionCompletionHandler = completionHandler
    }
}
