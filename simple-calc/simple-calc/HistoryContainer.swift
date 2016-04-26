//
//  HistoryContainer.swift
//  simple-calc
//
//  Created by Barron, Brandon on 4/26/16.
//  Copyright © 2016 Barron, Brandon. All rights reserved.
//

import Foundation


class HistoryContainer {
    
    static let sharedContainer = HistoryContainer()
    var history : [String]?
    let defaultsKey = "history"
    var goToBackgroundObserver : AnyObject?
    
    init() {
        let defaults = NSUserDefaults.standardUserDefaults()
        history = defaults.objectForKey(defaultsKey) as! [String]?
    }
    
    func addToHistory(item : String) {
        if history == nil {
            history = []
        }
        history?.append(item)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(self.history, forKey: defaultsKey)
    }
    
}
