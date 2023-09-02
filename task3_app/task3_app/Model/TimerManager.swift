//
//  TimerManager.swift
//  task3_app
//
//  Created by Mesut Gedik on 1.09.2023.
//

import AVFoundation
import UIKit

struct TimerManager {
    let minuteArray = Array(0...59)
    let secondArray = Array(0...59)
    
    
    
    
    // MARK: - Creating an Alarm

    private func setAlarmButtonTapped(selectedMinute minute: Int, selectedSecond second: Int) {
        
        // Create a UNMutableNotificationContent
        let content = UNMutableNotificationContent()
        content.title = "Timer has elapsed!"
        content.body = "Hurry Up Hurry Up"
        content.sound = .criticalSoundNamed(UNNotificationSoundName(rawValue: "wakeup.mp3"), withAudioVolume: 1)
        
        
        // Create a trigger based on the date
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        // Create a request with the content and trigger
        let request = UNNotificationRequest(identifier: "timerElapsed", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
//        callTheAlart()
        
    }
    
    
}
