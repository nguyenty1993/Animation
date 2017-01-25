//
//  NSZoomTransitionAnimator.swift
//  NSZoomTransitionAnimator
//
//  Created by naoyashiga on 2015/06/25.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

@objc public protocol NSZoomTransitionAnimating {
    func transitionSourceImageView() -> UIImageView
    func transitionSourceBackgroundColor() -> UIColor
    func transitionDestinationImageViewFrame() -> CGRect
}

let kForwardAnimationDuration: TimeInterval = 0.1
let kForwardCompleteAnimationDuration: TimeInterval = 0.1
let kBackwardAnimationDuration: TimeInterval = 0.1
let kBackwardCompleteAnimationDuration: TimeInterval = 0.1

class NSZoomTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var goingForward: Bool = false
    var sourceVC = UIViewController()
    var destinationVC = UIViewController()
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if goingForward {
            return kForwardAnimationDuration + kForwardCompleteAnimationDuration;
        } else {
            return kBackwardAnimationDuration + kBackwardCompleteAnimationDuration;
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let sourceImageView = UIImageView()
        var destinationImageView = UIImageView()
        
        var destinationImageViewFrame = CGRect()
        
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        
        containerView.addSubview(fromVC.view)
        containerView.addSubview(toVC.view)
        
        toVC.view.setNeedsLayout()
        toVC.view.layoutIfNeeded()
        
        if let sourceViewController = sourceVC as? NSZoomTransitionAnimating {
//            sourceImageView = sourceViewController.transitionSourceImageView()
            sourceImageView.image = sourceViewController.transitionSourceImageView().image
            sourceImageView.frame = sourceViewController.transitionSourceImageView().frame
            containerView.addSubview(sourceImageView)
        }
        
        if let destinationViewController = destinationVC as? NSZoomTransitionAnimating {
            destinationImageView = destinationViewController.transitionSourceImageView()
            destinationImageView.isHidden = true
            
            destinationImageViewFrame = destinationViewController.transitionDestinationImageViewFrame()
        }
        
        if self.goingForward {
            UIView.animate(withDuration: kForwardAnimationDuration, delay: 0, options: .curveEaseOut, animations: {
                sourceImageView.frame = destinationImageViewFrame
                
                }, completion: {(finished: Bool) in
                    if finished {
                        destinationImageView.isHidden = false
                        sourceImageView.removeFromSuperview()
                    }
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        } else {
            UIView.animate(withDuration: kBackwardAnimationDuration, delay: 0, options: .curveEaseOut, animations: {
                sourceImageView.frame = destinationImageViewFrame
                print(sourceImageView.frame)
                
                }, completion: {(finished: Bool) in
                    if finished {
                        destinationImageView.removeFromSuperview()
                        
                        print(sourceImageView.frame)
                        sourceImageView.removeFromSuperview()
                    }
                    
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
}
