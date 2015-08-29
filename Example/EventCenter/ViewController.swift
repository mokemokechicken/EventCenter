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
        
        
        // Handlers called only when the posted object-type is equal to the hander's arg-type.
        ec.register(self) { (event: MyAwesomeModel.UpdateEvent) in
            self.updateView()
        }
        
        ec.register(self) { (event: MyAwesomeModel.StoreEvent) in
            switch(event) {
            case .SUCCESS:
                print("store ok!")
            case .ERROR:
                print("store error!")
            }
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
    enum StoreEvent {
        case SUCCESS
        case ERROR
    }
    
    func notifyUpdate() {
        EventCenter.defaultCenter.post(UpdateEvent())
    }
    
    func notifyStoreResult() {
        EventCenter.defaultCenter.post(StoreEvent.SUCCESS)
    }
}



// If you want to see more cases, see also Tests.swift
