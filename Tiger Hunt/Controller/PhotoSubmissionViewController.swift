//
//  PhotoSubmissionViewController.swift
//  Tiger Hunt
//
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

class PhotoSubmissionViewController: UIViewController {
    @IBAction func switchViewController(_ sender: UIButton) {
        self.switchRootController(storyboardName: "Main")
    }
}
