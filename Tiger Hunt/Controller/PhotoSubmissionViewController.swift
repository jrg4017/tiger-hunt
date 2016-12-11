//
//  PhotoSubmissionViewController.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/11/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

class PhotoSubmissionViewController: UIViewController {
    
    @IBAction func switchViewController(_ sender: UIButton) {
        self.switchRootController(storyboardName: "Main")
    }
}
