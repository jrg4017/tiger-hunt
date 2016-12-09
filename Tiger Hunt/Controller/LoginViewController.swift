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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customBottomBorder(self.usernameTextField!)
        customBottomBorder(self.passwordTextField!)
    }
    
    // MARK: - IBAction
    @IBAction func loginUser(_ sender: UIButton) {
        
    }
    
    
}
