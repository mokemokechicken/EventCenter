# EventCenter

[![CI Status](http://img.shields.io/travis/mokemokechicken/EventCenter.svg?style=flat)](https://travis-ci.org/mokemokechicken/EventCenter)
[![Version](https://img.shields.io/cocoapods/v/EventCenter.svg?style=flat)](http://cocoapods.org/pods/EventCenter)
[![License](https://img.shields.io/cocoapods/l/EventCenter.svg?style=flat)](http://cocoapods.org/pods/EventCenter)
[![Platform](https://img.shields.io/cocoapods/p/EventCenter.svg?style=flat)](http://cocoapods.org/pods/EventCenter)

EventCenter is a swift library like Android's EventBus.
Observers can register type safe handlers(no need to type casting!), and unregister.
The handler's running thread can be specified when registering the hander.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

developed on swift 1.2

## Installation

EventCenter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:


```ruby
pod "EventCenter"
```

## Example

```
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

        ec.registerOnMainThread(self, handler: onEvent)
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
```


## Author

Ken Morishita, mokemokechicken@gmail.com


## License

EventCenter is available under the MIT license. See the LICENSE file for more info.
