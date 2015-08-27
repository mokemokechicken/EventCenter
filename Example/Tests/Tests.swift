// https://github.com/Quick/Quick

import Quick
import Nimble
import EventCenter

class EventCenterSpec: QuickSpec {
    var called2: Int = 0
    
    override func spec() {
        afterEach {
            EventCenter.defaultCenter.unregister(self)
        }
        
        describe("EventCenter Basic") {

            it("can register and unregister Handler") {
                let ec = EventCenter.defaultCenter  // use default EventCenter
                var called = 0
                ec.register(self) { (num: Int) in
                    expect(num) == 99
                    called++
                }
                ec.post(99)
                

                ec.unregister(self)
                ec.post(100)  // not handled
                
                ec.register(self) { (num: Int) in
                    expect(num) == 101
                    called++
                }
                ec.post(101)

                expect(called) == 2
            }
            
            it("Only Called Correct Type Handler") {
                let ec = EventCenter()  // can use original EventCenter
                
                var called = 0
                ec.register(self) { (num: Int) in
                    expect(num) == 200
                    called++
                }
                ec.register(self) { (s: String) in
                    expect(s) == "yes!"
                    called++
                }
                
                ec.post(200)
                ec.post("yes!")
                expect(called) == 2
            }
            
            it("Event Message can be Class Instance and Struct Value") {
                let ec = EventCenter.defaultCenter
                var called = 0
                self.called2 = 0
                
                ec.register(self) { (event: MyEvent) in
                    expect(event.num) == 50
                    called++
                }
                
                ec.register(self) { (event: ChildEvent) in
                    expect(event.num) == 60
                    called++
                }
                
                ec.register(self) { (event: MyEventStruct) in
                    expect(event.name) == "struct event"
                    called++
                }
                
                ec.register(self, handler: self.myHandler)
                
                ec.post(MyEvent(num: 50))
                ec.post(ChildEvent(num: 60))
                ec.post(MyEventStruct(name: "struct event"))
                
                expect(called) == 3
                expect(self.called2) == 1
            }
        }
        
        describe("EventCenter and Thread") {
            it("can register a handler called on main thread") {
                let ec = EventCenter.defaultCenter
                var called = 0
                
                ec.registerOnMainThread(self) { (num: Int) in
                    expect(num) == 30
                    expect(NSThread.isMainThread()) == true
                    called++
                }
                
                ec.register(self) { (num: Int) in
                    expect(num) == 30
                    expect(NSThread.isMainThread()) == false
                    called++
                }
                
                ec.register(self, queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) { (num: Int) in
                    expect(num) == 30
                    expect(NSThread.isMainThread()) == false
                    called++
                }
                
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                    expect(NSThread.isMainThread()) == false
                    ec.post(30)
                }
                
                expect(called) == 0

                NSThread.sleepForTimeInterval(0.5)

                waitUntil { done in
                    NSThread.sleepForTimeInterval(0.9)
                    expect(called) == 3
                    done()
                }
            }
        }
    }
    
    func myHandler(event: MyEvent) {
        expect(event.num) == 50
        called2++
    }
    
}

class MyEvent {
    let num: Int
    init(num: Int) {
        self.num = num
    }
}

class ChildEvent : MyEvent {}

struct MyEventStruct {
    let name: String
}

//        describe("these will fail") {
//
//            it("can do maths") {
//                expect(1) == 2
//            }
//
//            it("can read") {
//                expect("number") == "string"
//            }
//
//            it("will eventually fail") {
//                expect("time").toEventually( equal("done") )
//            }
//
//            context("these will pass") {
//
//                it("can do maths") {
//                    expect(23) == 23
//                }
//
//                it("can read") {
//                    expect("🐮") == "🐮"
//                }
//
//                it("will eventually pass") {
//                    var time = "passing"
//
//                    dispatch_async(dispatch_get_main_queue()) {
//                        time = "done"
//                    }
//
//                    waitUntil { done in
//                        NSThread.sleepForTimeInterval(0.5)
//                        expect(time) == "done"
//
//                        done()
//                    }
//                }
//            }
//        }
