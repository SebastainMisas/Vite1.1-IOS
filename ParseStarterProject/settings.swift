//
//  settings.swift
//  vite1.1
//
//  Created by Sebastian Misas on 1/25/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class settingsTabBar: UIViewController {
    @IBAction func unwindSegue(segue: UIStoryboardSegue) { }
    let transitionManager = TransitionManager()
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // this gets a reference to the screen that we're about to transition to
        let toViewController = segue.destinationViewController as UIViewController
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        toViewController.transitioningDelegate = self.transitionManager
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

