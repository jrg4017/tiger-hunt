//
//  SignUpViewController.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/9/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customBottomBorder(self.nameTextField!)
        customBottomBorder(self.emailTextField!)
        customBottomBorder(self.usernameTextField!)
        customBottomBorder(self.passwordTextField!)
        customBottomBorder(self.confirmPassTextField!)
    }
}
