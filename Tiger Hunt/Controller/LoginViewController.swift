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
    var user: User!
    
    // MARK: Constants
    let LOGIN_ERROR_TITLE: String = "Log In Error"
    let LOGIN_ERROR_MSG: String = "Your username or password is inccorect. Please try again"
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.customBottomBorder(self.usernameTextField!)
        self.customBottomBorder(self.passwordTextField!)
    }
    
    // MARK: - IBAction
    @IBAction func loginUser(_ sender: UIButton) {
        if self.usernameTextField.text == "" || passwordTextField.text == "" {
            self.loginAlert(title: self.LOGIN_ERROR_TITLE, msg: self.LOGIN_ERROR_MSG, textField: self.passwordTextField! )
        } else {
            // TODO:  implement get user info here
            self.user = User(name: "Julie Gabler", email: "jrgabler@gmail.com", username: self.usernameTextField.text!, totalPoints: 10)
            self.writeSession()
            self.switchRootController(storyboardName: "Main")
        }
    }
    
    func writeSession() {
        let userData = NSKeyedArchiver.archivedData(withRootObject: user)
        
        let defaults = UserDefaults.standard
        defaults.set(userData, forKey: "user")
        defaults.synchronize()
    }
}
