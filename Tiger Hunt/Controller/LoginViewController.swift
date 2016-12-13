//
//  LoginViewController.swift
//  Tiger Hunt
//
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logoImageView: UIImageView!

    @IBOutlet weak var loginButton: UIButton!
    var user: User?
    @IBOutlet var forgotPasswordButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    private(set) lazy var textFieldArray: [UITextField] = { return self.setTextFieldArray() }()
    
    private(set) lazy var buttonArray: [UIButton] = { return self.setButtonArray() }()
    
    // MARK: - Lifeycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.hideTextFields()
        
        self.customBottomBorder(self.emailTextField!)
        self.customBottomBorder(self.passwordTextField!)
        
        animateLoginScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.textFieldIsHidden(true, self.textFieldArray)
        self.setButtonsHidden(true, self.buttonArray)
    }
    
    // MARK: - SET UIVIEW ELEMENTS
    func setTextFieldArray() -> [UITextField] {
        return [self.emailTextField, self.passwordTextField]
    }
    
    func setButtonArray() -> [UIButton] {
        return [self.loginButton, self.forgotPasswordButton, self.registerButton]
    }
    
    // MARK: - IBAction
    @IBAction func loginUser(_ sender: UIButton) {
        FIRAuth.auth()!.signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
            
            if error != nil {
                if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
                    var msg = ""
                    switch errCode {
                    case .errorCodeUserDisabled:
                        msg = Constants.ACCOUNT_NOT_ENABLED
                    default:
                        msg = Constants.LOGIN_ERROR_MSG
                    }
                    
                    self.loginAlert(title: Constants.LOGIN_ERROR_TITLE, msg: msg, textField: self.passwordTextField)
                }
            } else {
                self.writeUID((user?.uid)!)
                self.switchRootController(storyboardName: "Main")
            }
        }
    }
    
    // MARK: - HELPER FUNCS FOR ANIMATION
    func hideTextFields() {
        let width = self.view.bounds.width
        self.emailTextField.center.x -= width
        self.passwordTextField.center.x -= width
        self.loginButton.center.x -= width
        self.registerButton.center.x -= width
        self.forgotPasswordButton.center.x -= width
    }
    
    
    func animateLoginScreen() {
        self.textFieldIsHidden(false, self.textFieldArray)
        self.setButtonsHidden(false, self.buttonArray)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
                let scale = CGAffineTransform(scaleX: 0.75, y: 0.75)
                self.logoImageView.transform = scale
            }, completion: nil)
        
        var delay = 1.0

        for textField in self.textFieldArray {
            self.slideView(textField, direction: "right", delayStart: delay)
            delay += Constants.ANIMATION_DELAY
        }
        
        for button in self.buttonArray {
            self.slideView(button, direction: "right", delayStart: delay)
            delay += Constants.ANIMATION_DELAY
        }
    }
}
