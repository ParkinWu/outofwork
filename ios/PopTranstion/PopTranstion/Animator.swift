//
//  Animator.swift
//  PopTranstion
//
//  Created by parkinwu on 16/9/6.
//  Copyright © 2016年 parkinwu. All rights reserved.
//

import UIKit

class Animator:NSObject, UIViewControllerAnimatedTransitioning {
    var appearing: Bool = false
    var duration: NSTimeInterval = 0.25
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if self.appearing {

            let toView = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)?.view
            let fromFrame = CGRectMake(0, UIScreen.mainScreen().bounds.size.height - 185, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
            let toFrame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
            toView?.frame = fromFrame
            toView?.backgroundColor = UIColor.clearColor()
            transitionContext.containerView()?.addSubview(toView!)
            
            UIView.animateWithDuration(duration, animations: {
                toView?.frame = toFrame
                toView?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
                }, completion: { (finish) in
                    
                 transitionContext.completeTransition(true)
            })
            
            
        } else {
            let toView = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view
            let toFrame = CGRectMake(0, UIScreen.mainScreen().bounds.size.height - 185, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
            let fromFrame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
            toView?.frame = fromFrame
            
            transitionContext.containerView()?.addSubview(toView!)
            
            UIView.animateWithDuration(duration, animations: {
                toView?.backgroundColor = UIColor.clearColor()
                toView?.frame = toFrame
                }, completion: { (finish) in
                    transitionContext.completeTransition(true)
            })
        }
    }
}
