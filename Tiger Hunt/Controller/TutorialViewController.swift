//
//  TutorialViewController.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/11/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tutorialPageViewController = segue.destination as? TutorialPageViewController {
            tutorialPageViewController.tutorialDelegate = self
        }
    }
}
