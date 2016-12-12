//
//  LoginViewController.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/9/16.
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
    
    private(set) lazy var textFieldArray: [UITextField] = { return self.setTextFieldArray() }()
    
    
    // MARK: - Lifeycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setTextFieldArray() -> [UITextField] {
        return [self.emailTextField, self.passwordTextField]
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
        self.loginButton.isHidden = true
    }
    
    func hideTextFields() {
        let width = self.view.bounds.width
        self.emailTextField.center.x -= width
        self.passwordTextField.center.x -= width
        self.loginButton.center.x -= width
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
            delay += Constants.ANIMATION_DELAY
        }

        self.slideView(self.loginButton, direction: "right", delayStart: delay)
    }
}
