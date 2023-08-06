//
//  LoginViewController.swift
//  NetWorking1
//
//  Created by Quasar on 27.06.2023.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    
   lazy var fbLoginButton: UIButton = {
        let loginButton = FBLoginButton()
        loginButton.frame = CGRect(x: 32, y: 320, width: view.frame.width - 64, height: 50)
       loginButton.delegate = self
        return loginButton
   }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addVerticalGradientLayer(topColor: primaryColor , bottomColor: secondaryColor)
        
        setupViews()
            // видео 15.30
        if AccessToken.isCurrentAccessTokenActive {
            print("the user is logged in")
        }
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    private func setupViews() {
        view.addSubview(fbLoginButton)
    }
    

}

extension LoginViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginKit.FBLoginButton, didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?, error: Error?) {
        
        if error != nil {
            print(error as Any)
            return
        }
        
        print("Successfully logged in with facebook...")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
        
        print("Did log out of facebook")
    }
    
    
}
