//
//  ViewController.swift
//  router
//
//  Created by parkinwu on 2016/9/27.
//  Copyright © 2016年 parkinwu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func toFirst(sender: AnyObject) {
        let url = URL(string: "MyApp://?token=123")
        
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.openURL(url!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

