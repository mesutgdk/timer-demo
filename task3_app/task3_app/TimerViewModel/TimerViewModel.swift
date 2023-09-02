//
//  TimerViewModel.swift
//  task3_app
//
//  Created by Mesut Gedik on 1.09.2023.
//

import Foundation

enum TimerState {
    case paused
    case running
}
class TimerViewModel {
    var timerModel = TimerModel()
    
    var timerState: TimerState = .paused
    
    func toggleTimerState(){
        timerState = (timerState == .paused) ? .running : .paused
    }
    
    func startTimer(withMinutes minutes: Int, seconds: Int) {
        let totalSeconds = minutes * 60 + seconds
        timerModel.remainingTime = TimeInterval(totalSeconds)
        timerModel.isRunning = true
        timerModel.isPaused = false
    }
    
    func pauseTimer() {
        timerState = .paused
        timerModel.isPaused = true
    }
    
//    func resumeTimer() {
//        timerModel.isPaused = false
//    }
    
    func stopTimer() {
        timerModel.remainingTime = 0
        timerModel.isRunning = false
        timerModel.isPaused = false
    }
    
    func updateTimer() {
        if timerModel.isRunning && !timerModel.isPaused {
            timerModel.remainingTime -= 1
        }
    }
}
