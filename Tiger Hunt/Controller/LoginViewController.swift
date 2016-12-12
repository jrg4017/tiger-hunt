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
    
    private(set) lazy var textFieldArray: [UITextField] = { return self.setTextFieldArray() }()
    let ANIMATION_DELAY: Double = 0.1

    
    // MARK: - Lifeycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setTextFieldArray() -> [UITextField] {
        return [self.usernameTextField, self.passwordTextField]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.hideTextFields()
        
        self.customBottomBorder(self.usernameTextField!)
        self.customBottomBorder(self.passwordTextField!)
        
        animateLoginScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.textFieldIsHidden(true, self.textFieldArray)
        self.loginButton.isHidden = true
    }
    
    func hideTextFields() {
        let width = self.view.bounds.width
        self.usernameTextField.center.x -= width
        self.passwordTextField.center.x -= width
        self.loginButton.center.x -= width
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
        self.textFieldIsHidden(false, self.textFieldArray)
        self.loginButton.isHidden = false
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .beginFromCurrentState, animations: {
                let scale = CGAffineTransform(scaleX: 0.75, y: 0.75)
                self.logoImageView.transform = scale
            }, completion: nil)
        
        var delay = 1.0

        for textField in textFieldArray {
            self.slideView(textField, direction: "right", delayStart: delay)
            delay += self.ANIMATION_DELAY
        }

        self.slideView(self.loginButton, direction: "right", delayStart: delay)
    }
}
