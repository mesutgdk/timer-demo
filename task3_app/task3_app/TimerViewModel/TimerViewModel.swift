//
//  TimerViewModel.swift
//  task3_app
//
//  Created by Mesut Gedik on 1.09.2023.
//

import Foundation

class TimerViewModel {
    var timerModel = TimerModel()
        
    func startTimer(withMinutes minutes: Int, seconds: Int) {
        let totalSeconds = minutes * 60 + seconds
        
        timerModel.remainingTime = TimeInterval(totalSeconds)
    }
    
    func pauseTimer() {
        timerModel.timerState = .paused
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
