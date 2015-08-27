//
//  ViewController.swift
//  EventCenter
//
//  Created by Ken Morishita on 08/27/2015.
//  Copyright (c) 2015 Ken Morishita. All rights reserved.
//

import UIKit
import EventCenter


class ViewController: UIViewController {

    override func viewWillAppear(animated: Bool) {
        let ec = EventCenter.defaultCenter
        
        ec.register(self) { (event: MyAwesomeModel.UpdateEvent) in
            self.updateView()
        }
        
        // or
        
        ec.register(self, handler: self.onEvent)
        
        // or
        
        ec.registerOnMainThread(self, handler: self.onEvent)
    }
    
    override func viewWillDisappear(animated: Bool) {
        EventCenter.defaultCenter.unregister(self)
    }
    
    func updateView() {
        // ...
    }
    
    func onEvent(event: MyAwesomeModel.UpdateEvent) {
        self.updateView()
    }
    
}


class MyAwesomeModel {
    class UpdateEvent {}
    
    func notify() {
        EventCenter.defaultCenter.post(UpdateEvent())
    }
}


// If you want to see more cases, see also Tests.swift
