//
//  HistoryViewController.swift
//  simple-calc
//
//  Created by Barron, Brandon on 4/26/16.
//  Copyright © 2016 Barron, Brandon. All rights reserved.
//

import Foundation
import UIKit


class HistoryViewController: UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        let history = HistoryContainer.sharedContainer.history ?? []
        
//        let scrollView = self.view.viewWithTag(1) as! UIScrollView
        let label = self.view.viewWithTag(42) as! UILabel
        
        history.reverse().forEach({ (calculation : String) -> () in
            print("adding calculation \"\(calculation)\"")
//            let label = UILabel()
//            label.text = calculation
//            scrollView.addSubview(label)
            label.text = (label.text ?? "") + "\(calculation)\n"
        })
//        scrollView.sizeToFit()
    }
    
}
