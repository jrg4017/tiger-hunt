//
//  TutorialPageViewController.swift
//  Tiger Hunt
//
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {
    // MARK: - PROPERTIES
    private(set) lazy var tutorialViewControllers: [UIViewController] = {
        return [self.newTutorialViewController("Marker"),
                self.newTutorialViewController("TaskList"),
                self.newTutorialViewController("PhotoSubmission")]
    }()

    // MARK: - INIT
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        if let firstViewController = self.tutorialViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    //MARK: - HELPER FUNC
    private func newTutorialViewController(_ tutorial: String) -> UIViewController {
        return UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "\(tutorial)TutorialVC")
    }

}

