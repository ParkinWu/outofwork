//
//  FirstViewController.swift
//  PopTranstion
//
//  Created by parkinwu on 16/9/12.
//  Copyright © 2016年 parkinwu. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func popAction(sender: AnyObject) {
        let popVC = SecondViewController(nibName: "SecondViewController", bundle: nil)
        self.presentViewController(popVC, animated: true, completion: nil)
    }
    @IBOutlet weak var pop: UIButton!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
