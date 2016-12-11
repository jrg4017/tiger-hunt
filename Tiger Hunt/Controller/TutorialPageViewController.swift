//
//  TutorialPageViewController.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/11/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {
    private(set) lazy var tutorialViewControllers: [UIViewController] = {
        return [self.newTutorialViewController("Marker"),
                self.newTutorialViewController("TaskList"),
                self.newTutorialViewController("PhotoSubmission")]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        if let firstViewController = self.tutorialViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func newTutorialViewController(_ tutorial: String) -> UIViewController {
        return UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "\(tutorial)TutorialVC")
    }

}

