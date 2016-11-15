//
//  ViewController.swift
//  Test
//
//  Created by parkinwu on 2016/11/4.
//  Copyright © 2016年 parkinwu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let makeWithDraw = { (balance: Int) -> ((String) -> ((Int) -> Int?)) in
        
        var total = balance
        
        let withDraw = { (amount: Int) -> Int? in
            
            if amount <= total {
                total = total - amount
                return total
            }
            return nil
        }
        
//        let deposit = { (amount: Int) -> Int? in
//            total = total + amount
//            return total
//        }
        
        func deposit(disposit amount: Int) -> Int? {
            total = total + amount
            return total
        }
        
        let dispatch = { (method: String) -> ((Int) -> Int?) in
            switch method {
            case "withDraw":
                return withDraw
            case "deposit":
                return deposit
            default:
                return withDraw
            }
            
        }
        
        return dispatch
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let w1 = makeWithDraw(100)
        print(w1("withDraw")(20))
        
        print(w1("deposit")(100))
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

