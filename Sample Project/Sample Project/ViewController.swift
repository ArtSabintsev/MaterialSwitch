//
//  ViewController.swift
//  Sample Project
//
//  Created by Arthur Sabintsev on 6/30/15.
//  Copyright (c) 2015 Arthur Ariel Sabintsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MaterialSwitchDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let size: MaterialSwitchSize = (0, 0, 44)
        let aSwitch = MaterialSwitch(size: size)
        aSwitch.setup(delegate: self)
        aSwitch.center = self.view.center
        self.view.addSubview(aSwitch)
    }
    
    func switchDidChangeState(#aSwitch: MaterialSwitch, currentState: MaterialSwitchState) {
        if currentState == .On {
            println("Switch was turned on")
        } else {
            println("Switch was turned off")
        }
        
    }
}
