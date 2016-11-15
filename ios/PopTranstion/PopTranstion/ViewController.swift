//
//  ViewController.swift
//  PopTranstion
//
//  Created by parkinwu on 16/9/6.
//  Copyright © 2016年 parkinwu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {

    var counter: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(updateCount), userInfo: nil, repeats: true)
        
    }

    func updateCount() {
        counter += 1
        self.title = "\(counter)"
        if counter == 5 {
            self.navigationController?.viewControllers.last?.dismissViewControllerAnimated(true, completion: { 
                self.navigationController?.popToRootViewControllerAnimated(true)
            })
            
        }
    }
    @IBAction func pop(sender: AnyObject) {
        let firstVC = FirstViewController(nibName: "FirstViewController", bundle: nil)
        self.navigationController?.pushViewController(firstVC, animated: true)
//        let popVC = PopViewController(nibName: "PopViewController", bundle: nil)
//        popVC.modalPresentationStyle = UIModalPresentationStyle.Custom
//        popVC.transitioningDelegate = self
//        self.presentViewController(popVC, animated: true) { 
//            
//        }
    }
    // MARK: - UIViewControllerTransitioningDelegate
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = Animator()
        animator.appearing = true
        animator.duration = 0.25
        return animator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = Animator()
        animator.appearing = false
        animator.duration = 0.25
        return animator
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

