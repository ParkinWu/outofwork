//
//  ViewController.swift
//  AddVCTest
//
//  Created by parkinwu on 16/8/30.
//  Copyright © 2016年 parkinwu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let firstVC = FirstViewController(nibName: "FirstViewController", bundle: nil)
    let secondVC = SecondViewController(nibName: "SecondViewController", bundle: nil)
    let thirdVC = ThirdViewController(nibName: "ThirdViewController", bundle: nil)
    
    

    @IBOutlet weak var contentView: UIView!
    var currentVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let scrollView = self.view as! UIScrollView
        scrollView.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width * 3, UIScreen.mainScreen().bounds.size.height)
        scrollView.pagingEnabled = true
        print(self.view)
        
        self.addChildViewController(firstVC)
        self.addChildViewController(secondVC)
        self.addChildViewController(thirdVC)
        let frame = CGRectMake(0, 64, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - 64)
        firstVC.view.frame = frame
        secondVC.view.frame = frame
        thirdVC.view.frame = frame
        self.view.addSubview(firstVC.view)
        currentVC = firstVC

    }

    @IBAction func next(sender: UIButton) {
        let index = sender.tag - 100
        let willMoveToVC = self.childViewControllers[index]
        if currentVC == willMoveToVC {
            return
        }
        willMoveToVC.willMoveToParentViewController(self)
        self.transitionFromViewController(currentVC!, toViewController: willMoveToVC, duration: 0.25, options: UIViewAnimationOptions.CurveLinear, animations: { [unowned self] in
                
            
            }) { [unowned self] (finish) in
                willMoveToVC.didMoveToParentViewController(self)
                self.currentVC = willMoveToVC
                print(self.childViewControllers)
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

