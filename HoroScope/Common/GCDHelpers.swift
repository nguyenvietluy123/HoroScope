//
//  GCDHelpers.swift
//  NewLinePro
//
//  Created by Tony Tuong on 1/14/17.
//  Copyright © 2017 Võ Hồng Nghĩa. All rights reserved.
//

import Foundation

typealias GCDClosure = () -> Void
typealias GCDClosureProgress = (_ value: Float) -> Void

enum QueueType {
    case main
    case high
    case defaultQ
    case low
    case background
    
    func getQueue() -> DispatchQueue {
        switch self {
        // return concurrent queue with hight priority
        case .high:
            return DispatchQueue(label: "GCD.LinePro.High", qos: DispatchQoS.userInteractive, attributes: [.concurrent])
        case .defaultQ:
            return DispatchQueue(label: "GCD.LinePro.Default", qos: DispatchQoS.default, attributes: [.concurrent])
        case .low:
            return DispatchQueue(label: "GCD.LinePro.Utility", qos: DispatchQoS.utility, attributes: [.concurrent])
        case .background:
            return DispatchQueue(label: "GCD.LinePro.Background", qos: DispatchQoS.background, attributes: [.concurrent])
        case .main:
            return DispatchQueue.main
        }
    }
}

// MARK: Update UI Main
class GCDCommon {
    
    class func mainQueueWithDelay(_ delay: Double, _ main: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            main()
        }
    }
    
    class func mainQueue(_ main: @escaping () -> Void) {
        DispatchQueue.main.async {
            // update the ui
            main()
        }
    }
    
    class func mainToBackground(_ background: @escaping () -> Void, main: @escaping () -> Void) {
        let priority = QueueType.defaultQ
        priority.getQueue().async {
            // do some task
            background()
            DispatchQueue.main.async {
                // update the ui
                main()
            }
        }
    }
    
    class func progressTaskInBackground(_ background: @escaping () -> Void) {
        let priority = QueueType.high
        priority.getQueue().async {
            // do some task
            background()
        }
    }
}

class GCDGroupOperations {
    var totalTask: Int = 0
    private var countTaskComplection: Int = 0
    private var gcdGroup: DispatchGroup
    private var dispathQueue: DispatchQueue
    var progress: GCDClosureProgress?

    /**
     * Creat GCD Group
     * Param is Total task will run in group
     * Param can nil.
     */
    required init(totalTask: Int? = nil,_ queueRun: DispatchQueue = DispatchQueue(label: "com.linepro.dispatchgroup", attributes: .concurrent, target: .main)) {
        self.dispathQueue = queueRun
        self.gcdGroup = DispatchGroup()
        self.gcdGroup.wait()
        if let totalTask = totalTask {
            self.totalTask = totalTask
            self.countTaskComplection = totalTask
        }
    }
        
    // MARK: Function Public
    func enter(addTask: @escaping GCDClosure) {
        gcdGroup.enter()
        self.dispathQueue.async {
            addTask()
        }
    }
    
    func enterSync(addTask: @escaping GCDClosure) {
        gcdGroup.enter()
        self.dispathQueue.sync {
            addTask()
        }
    }
    
    func leave() {
        if countTaskComplection > 0 { countTaskComplection -= 1 }
        let progress = Float(totalTask - countTaskComplection) / Float(totalTask)
        self.progress?(progress)
        gcdGroup.leave()
    }
    
    func decrease() {
        if countTaskComplection > 0 { countTaskComplection -= 1 }
        let progress = Float(totalTask - countTaskComplection) / Float(totalTask)
        self.progress?(progress)
    }
    
    func notify(queueType: QueueType = QueueType.main, closure: @escaping GCDClosure) {
        gcdGroup.notify(queue: queueType.getQueue(), execute: closure)
    }
}
