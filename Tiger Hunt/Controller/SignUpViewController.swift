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
    
    var textFieldArray: [UITextField] = []
    
    // MARK: - Lifeycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textFieldArray = [self.nameTextField, self.emailTextField, self.usernameTextField, self.passwordTextField, self.confirmPassTextField]
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for textField in self.textFieldArray {
            self.customBottomBorder(textField)
        }
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
