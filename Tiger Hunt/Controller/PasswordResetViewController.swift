//
//  PasswordResetViewController.swift
//  Tiger Hunt
//
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit
import FirebaseAuth

class PasswordResetViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var emailResetTextField: UITextField!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    // MARK: - IBACTION
    @IBAction func resetPassword(_ sender: UIButton) {
        
        FIRAuth.auth()?.sendPasswordReset(withEmail: self.emailResetTextField.text!, completion: { error in
            let msg = (error == nil) ? Constants.PASSWORD_RESET_MSG : Constants.GENERIC_ERROR_MSG
        
            self.loginAlert(title: Constants.PASSWORD_RESET_TITLE, msg: msg, textField: nil)
        })
    }
}
