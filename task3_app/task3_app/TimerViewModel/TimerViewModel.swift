//
//  TimerViewModel.swift
//  task3_app
//
//  Created by Mesut Gedik on 1.09.2023.
//

import Foundation

class TimerViewModel {
    var timerModel = TimerModel()
    
    var pausedTime: TimeInterval = 0
    
    func startTimer(withMinutes minutes: Int, seconds: Int) {
        let totalSeconds = minutes * 60 + seconds
        
        timerModel.remainingTime = TimeInterval(totalSeconds)
//        print(timerModel.remainingTime)
    }
    
    func pauseTimer() {
        timerModel.timerState = .paused
//        timerModel.remainingTime = TimeInterval(pausedTime)
    }
    
    func resumeTimer() {
        timerModel.toggleTimerState()
//        timerModel.remainingTime = TimeInterval(pausedTime)
    }
    
    func stopTimer() {
        timerModel.remainingTime = 0
        timerModel.timerState = .stopped
    }
    
    func updateTimer() {
        if timerModel.timerState == .running {
            timerModel.remainingTime -= 1
        }
    }
}
