//
//  SignUpViewController.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/9/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var logoImageView: UIImageView!
    private(set) lazy var textFieldArray: [UITextField] = { return self.setTextFieldArray() }()
    
    var user: User?

    // MARK: - Lifeycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setTextFieldArray() -> [UITextField] {
        return [self.nameTextField, self.emailTextField, self.passwordTextField, self.confirmPassTextField]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //hide before animating
        self.logoImageView.isHidden = true
        self.textFieldIsHidden(true, self.textFieldArray)
        self.registerButton.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //show so we can see the view come in
        self.logoImageView.isHidden = false
        self.textFieldIsHidden(false, self.textFieldArray)
        self.registerButton.isHidden = false
        
        let width = self.view.bounds.width
        
        for textField in self.textFieldArray {
            textField.center.x += width
        }
        self.logoImageView.center.x += width
        self.registerButton.center.x += width
         
        for textField in self.textFieldArray {
            self.customBottomBorder(textField)
        }
        
        animateSignUpScreen()
    }
    
    func animateSignUpScreen() {
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .beginFromCurrentState, animations: {
                let scale = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.logoImageView.transform = scale
            }, completion: nil)
        
        var delay = 1.0
        
        self.slideView(self.logoImageView, direction: "left", delayStart: delay)
        delay += Constants.ANIMATION_DELAY
        
        for textField in textFieldArray {
            self.slideView(textField, direction: "left", delayStart: delay)
            delay += Constants.ANIMATION_DELAY
        }
        
        self.slideView(self.registerButton, direction: "left", delayStart: delay)
        
    }
    
    @IBAction func registerUser(_ sender: UIButton) {
        FIRAuth.auth()!.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { user, error in
            if error != nil {
                if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
                    var msg = ""
                    switch errCode {
                        case .errorCodeWeakPassword:
                            //msg = self.ACCOUNT_NOT_ENABLED
                            msg = Constants.WEAK_PASSWORD_MSG
                        case .errorCodeInvalidEmail:
                            msg = Constants.INVALID_EMAIL_MSG
                        default:
                            msg = Constants.GENERIC_ERROR_MSG
                        }
                    
                    self.loginAlert(title: Constants.SIGNUP_ERROR_TITLE, msg: msg, textField: self.passwordTextField)
                }
            } else {
                FIRAuth.auth()!.signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!)
                self.writeUID((user?.uid)!)
                let newUser = self.loadUser(user!, self.nameTextField.text!)
                DataService.dataService.persistUser(newUser)
            }
        }
    }
}
