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
    private(set) lazy var textFieldArray: [UITextField] = { return self.setTextFieldArray() }()
    
    let ANIMATION_DELAY: Double = 0.1
    
    // MARK: - Lifeycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setTextFieldArray() -> [UITextField] {
        return [self.nameTextField, self.emailTextField, self.usernameTextField, self.passwordTextField, self.confirmPassTextField]
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
        delay += ANIMATION_DELAY
        
        for textField in textFieldArray {
            self.slideView(textField, direction: "left", delayStart: delay)
            delay += ANIMATION_DELAY
        }
        
        self.slideView(self.registerButton, direction: "left", delayStart: delay)
        
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
