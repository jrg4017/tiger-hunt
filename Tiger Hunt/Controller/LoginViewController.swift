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
    @IBOutlet weak var logoImageView: UIImageView!
    var user: User!
    @IBOutlet weak var loginButton: UIButton!
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
        
        animateLoginScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
        self.usernameTextField.alpha = 0.0
        self.passwordTextField.alpha = 0.0
        self.loginButton.alpha = 0.0
        
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
    
    func animateLoginScreen() {
        UIView.animate(withDuration: 1.2, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .beginFromCurrentState, animations: {
                let scale = CGAffineTransform(scaleX: 0.75, y: 0.75)
                self.logoImageView.transform = scale
            }, completion: nil)
        
        UIView.animate(withDuration: 1.0, delay: 1.2, options: .curveEaseIn, animations: {
            self.usernameTextField.alpha = 1.0
            }, completion: nil)
        
        UIView.animate(withDuration: 1.0, delay: 1.3, options: .curveEaseIn, animations: {
            self.passwordTextField.alpha = 1.0
            }, completion: nil)
        
        UIView.animate(withDuration: 1.0, delay: 1.4, options: .curveEaseIn, animations: {
            self.loginButton.alpha = 1.0
            }, completion: nil)
        
    }
}
