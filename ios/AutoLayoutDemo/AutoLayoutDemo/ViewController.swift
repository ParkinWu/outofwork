//
//  ViewController.swift
//  AutoLayoutDemo
//
//  Created by parkinwu on 2016/11/2.
//  Copyright © 2016年 parkinwu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
    }
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
    }
    @IBAction func changeConstraint(_ sender: UIButton) {
        heightConstraint.constant += 20;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

