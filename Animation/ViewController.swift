//
//  ViewController.swift
//  Animation
//
//  Created by Ty Nguyen on 1/11/17.
//  Copyright © 2017 Ty Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate,NSZoomTransitionAnimating{
    
    var transition = CircularTransition()

    @IBOutlet weak var lbNumberOrdinal: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    let total = 7
    var ordinal = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        //Add many UISwipeGestureRecognizer for view
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        //Customize number ordinal of many images
        let mutableString = NSMutableAttributedString(string: lbNumberOrdinal.text!, attributes: [NSFontAttributeName:UIFont(name: "Arial", size: 17.0)!])
        mutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.gray, range: NSRange(location:0,length:1))
        lbNumberOrdinal.attributedText = mutableString
        
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                ordinal -= 1;
                if(ordinal < 1){
                    ordinal = 7
                }
                imageView.image = UIImage(named: String(ordinal))
                lbNumberOrdinal.text = String(ordinal) + "/7"
                let myMutableString = NSMutableAttributedString(string: lbNumberOrdinal.text!, attributes: [NSFontAttributeName:UIFont(name: "Arial", size: 17.0)!])
                myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.gray, range: NSRange(location:0,length:1))
                lbNumberOrdinal.attributedText = myMutableString
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
                performSegue(withIdentifier: "Detail", sender: nil)
            case UISwipeGestureRecognizerDirection.left:
                ordinal += 1;
                if(ordinal > 7){
                    ordinal = 1
                }
                imageView.image = UIImage(named: String(ordinal))
                lbNumberOrdinal.text = String(ordinal) + "/7"
                let myMutableString = NSMutableAttributedString(string: lbNumberOrdinal.text!, attributes: [NSFontAttributeName:UIFont(name: "Arial", size: 17.0)!])
                
                myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.gray, range: NSRange(location:0,length:1))
                lbNumberOrdinal.attributedText = myMutableString
            case UISwipeGestureRecognizerDirection.up: break
                //print("Swiped up")
            default:
                break
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetail" {
            let vc = segue.destination as! DetailViewController
            vc.transitioningDelegate = self
            vc.imagefromViewMain = imageView.image!
        }
    }
    
    //MARK: NSZoomTransitionAnimating
    func transitionSourceImageView() -> UIImageView {
        return imageView
    }
    
    func transitionSourceBackgroundColor() -> UIColor {
        return UIColor.black
    }
    
    func transitionDestinationImageViewFrame() -> CGRect {
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        return rect
    }
    
    //MARK: UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = NSZoomTransitionAnimator()
        animator.sourceVC = source
        animator.destinationVC = presented
        animator.goingForward = true
        return animator
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

