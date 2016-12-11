//
//  ImageViewExtension.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/11/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

extension UIImageView {
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

