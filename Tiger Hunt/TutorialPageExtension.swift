//
//  TutorialPageExtension.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/11/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

extension TutorialPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.tutorialViewControllers.index(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else { return nil }
        guard self.tutorialViewControllers.count > previousIndex else { return nil }
        
        return self.tutorialViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.tutorialViewControllers.index(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        let count = self.tutorialViewControllers.count
        
        guard count != nextIndex else { return nil }
        guard count > nextIndex else { return nil }
        
        return self.tutorialViewControllers[nextIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
            let index = self.tutorialViewControllers.index(of: firstViewController) {
            self.tutorialDelegate?.tutorialPageViewController(tutorialPageViewController: self, didUpdatePageIndex: index)
        }
    }
}
