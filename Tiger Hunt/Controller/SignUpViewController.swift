//
//  SignUpViewController.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/9/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    var textFieldArray: [UITextField] = []
    
    let ANIMATION_DELAY: Double = 0.1
    
    // MARK: - Lifeycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textFieldArray = [self.nameTextField, self.emailTextField, self.usernameTextField, self.passwordTextField, self.confirmPassTextField]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for textField in self.textFieldArray {
            textField.alpha = 0
        }
        
        self.logoImageView.alpha = 0.0
        self.registerButton.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for textField in self.textFieldArray {
            self.customBottomBorder(textField)
        }
        
        animateSignUpScreen()
    }
    
    func animateSignUpScreen() {
        UIView.animate(withDuration: 1.2, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .beginFromCurrentState, animations: {
                let scale = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.logoImageView.transform = scale
            }, completion: nil)
        
        var delay = 1.3
        for textField in self.textFieldArray {
            UIView.animate(withDuration: 1.0, delay: delay, options: [], animations: {
                textField.center.x -= self.view.bounds.width
            }, completion: nil)
            delay += ANIMATION_DELAY
        }
        
        UIView.animate(withDuration: 1.0, delay: (delay + ANIMATION_DELAY), options: [], animations: {
            self.registerButton.center.x -= self.view.bounds.width
        }, completion: nil)

        UIView.animate(withDuration: 3.0, delay: 1.5, options: .curveEaseIn, animations: {
            self.registerButton.alpha = 1.0
            }, completion: nil)
        
    }

    // MARK: - Helper functions
    func verifyInput() {
//        for textField in textFieldArray {
//            if textField.text == "" {
//                loginAlert(title: String, msg: <#T##String#>, textField: <#T##UITextField#>)
//            }
//        }
    }
}
