//
//  TutorialPageViewControllerDelegate.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/11/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

protocol TutorialPageViewControllerDelegate: class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController, didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController, didUpdatePageIndex index: Int)
    
}
