//
//  UIViewControllerExtension.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/9/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

extension UIViewController {
    
    
    // MARK: - Custom border func
    func customBottomBorder(_ textField: UITextField) {
        let border = CALayer()
        let width = CGFloat(2.0)
        
        let colVal = CGFloat(187.0/255.0)
        let borderColor = UIColor(red: colVal, green: colVal, blue: colVal, alpha: 1.0)
        
        border.borderColor = borderColor.cgColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
        
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    
    func loginAlert(title: String,  msg: String, textField: UITextField ) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler:
            { action in textField.text = "" }
        )
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
