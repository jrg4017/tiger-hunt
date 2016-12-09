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
    func customBottomBorder(_ textField: UITextField, color: String) {
        let border = CALayer()
        let width = CGFloat(2.0)
        
        let colVal = CGFloat(187.0/255.0)
        var borderColor = UIColor(red: colVal, green: colVal, blue: colVal, alpha: 1.0)
        
        
        if color == "red" {
            borderColor = UIColor.red
        }
        
        
        border.borderColor = borderColor.cgColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
        
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
}
