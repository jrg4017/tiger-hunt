//
//  LoginViewController.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/9/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var user: User?
    
    // MARK: Constants
    let LOGIN_ERROR_TITLE: String = "Log In Error"
    let LOGIN_ERROR_MSG: String = "Your username or password is inccorect. Please try again"
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        customBottomBorder(self.usernameTextField!, color: "gray")
        customBottomBorder(self.passwordTextField!, color: "gray")
    }
    
    // MARK: - IBAction
    @IBAction func loginUser(_ sender: UIButton) {
        if self.usernameTextField.text == "" || passwordTextField.text == "" {
            loginAlert(title: LOGIN_ERROR_TITLE, msg: LOGIN_ERROR_MSG, textField: self.passwordTextField! )
        } else {
            // TODO:  implement get user info here
            user = User(name: "Julie Gabler", email: "jrgabler@gmail.com", username: usernameTextField.text!)
            print(user)
            writeSession()
            switchRootController()
        }
    }
    
    func writeSession() {
        let userData = NSKeyedArchiver.archivedData(withRootObject: user!)
        
        let defaults = UserDefaults.standard
        defaults.set(userData, forKey: "user")
        defaults.synchronize()
    }

    func switchRootController() {
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        appDelegate.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarControllerID")
        appDelegate.window?.makeKeyAndVisible()
    }
}
