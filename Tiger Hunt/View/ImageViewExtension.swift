//
//  ImageViewExtension.swift
//  Tiger Hunt
//
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

extension UIImageView {
    //MARK: - MASK CIRCLE FUNC
    public func maskCircle(view: UIView) {
        view.layoutIfNeeded()
        
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = false
        
        let colVal = CGFloat(187.0/255.0)
        let gray = UIColor(red: colVal, green: colVal, blue: colVal, alpha: 1.0)
        
        self.layer.borderColor = gray.cgColor
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
}

