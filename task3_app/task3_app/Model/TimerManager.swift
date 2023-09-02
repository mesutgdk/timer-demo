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
     
    // MARK: - Creating a Notification

    func callTheCops() {
        
        // Create a UNMutableNotificationContent
        let content = UNMutableNotificationContent()
        content.title = "Timer has elapsed!"
        content.body = "Hurry Up Hurry Up"
        content.sound = .criticalSoundNamed(UNNotificationSoundName(rawValue: "wakeup.mp3"), withAudioVolume: 1)
        
        
        // Create a trigger based on the date
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        // Create a request with the content and trigger
        let request = UNNotificationRequest(identifier: "timerElapsed", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully.")
            }
        }
    }
    
}
