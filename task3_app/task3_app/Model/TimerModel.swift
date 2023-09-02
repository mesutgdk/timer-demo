//
//  TimerModel.swift
//  task3_app
//
//  Created by Mesut Gedik on 1.09.2023.
//

import Foundation
enum TimerState {
    case stopped
    case paused
    case running
}

class TimerModel {
    var timerState: TimerState = .stopped
    
    func toggleTimerState(){
        timerState = (timerState == .paused) ? .running : .paused
    }
    var remainingTime: TimeInterval = 0
}
