//
//  NavigationController.swift
//  NSZoomTransitionAnimator
//
//  Created by naoyashiga on 2015/06/29.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
//        if fromVC.conformsToProtocol(NSZoomTransitionAnimating) && toVC.conformsToProtocol(NSZoomTransitionAnimating) {
//            let animator = NSZoomTransitionAnimator()
//            animator.sourceVC = fromVC
//            animator.destinationVC = toVC
//            animator.goingForward = (operation == UINavigationControllerOperation.push)
//            return animator
//        }
        let animator = NSZoomTransitionAnimator()
        animator.sourceVC = fromVC
        animator.destinationVC = toVC
        animator.goingForward = (operation == UINavigationControllerOperation.push)
        return animator
        
        //return nil
    }
}
