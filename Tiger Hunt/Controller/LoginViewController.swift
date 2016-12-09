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
    
    // MARK: Constants
    let LOGIN_ERROR_TITLE: String = "Log In Error"
    let LOGIN_ERROR_MSG: String = "Your username or password is inccorect. Please try again"
    
    var loginSession: String = ""
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLoginStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customBottomBorder(self.usernameTextField!, color: "gray")
        customBottomBorder(self.passwordTextField!, color: "gray")
    }
    
    // MARK: - IBAction
    @IBAction func loginUser(_ sender: UIButton) {
        loginAlert()
    }
    
    func loginAlert() {
        let alert = UIAlertController(title: LOGIN_ERROR_TITLE, message: LOGIN_ERROR_MSG, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { action in self.passwordTextField.text = ""})
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func checkLoginStatus() {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: "session") != nil {
            loginSession = preferences.object(forKey: "session") as! String
            //check_session()
           // navigationController?.popViewController(animated: true)
            //navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
        }
        else {
            //LoginToDo()
        }

    }
    
}
