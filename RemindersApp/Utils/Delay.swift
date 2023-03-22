//
//  Delay.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 22/03/23.
//

import Foundation

class Delay {
    
    private var workItem: DispatchWorkItem?
    
    init() {}
    
    func perfom(in delay: TimeInterval, work: @escaping ()->Void) {
        workItem = DispatchWorkItem {
            work()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.workItem?.perform()
        }
    }
    
    func cancel() {
        workItem?.cancel()
    }
}
