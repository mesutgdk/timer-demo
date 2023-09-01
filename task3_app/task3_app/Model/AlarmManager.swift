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
    
    
    
//    func getSelectedTimeFromPicker(pickerView: UIPickerView) {
//        let selectedHourRow = pickerView.selectedRow(inComponent: 0)
//        let selectedMinuteRow = pickerView.selectedRow(inComponent: 1)
//
//        let selectedMinute = minuteArray[selectedHourRow]
//        let selectedSecond = secondArray[selectedMinuteRow]
//
//        print(selectedMinute,selectedSecond)
//        setAlarmButtonTapped(selectedMinute: selectedMinute, selectedSecond: selectedSecond)
//    }
    
    // MARK: - Creating an Alarm

    private func setAlarmButtonTapped(selectedMinute minute: Int, selectedSecond second: Int) {
        
        // Create a UNMutableNotificationContent
        let content = UNMutableNotificationContent()
        content.title = "Timer has elapsed!"
        content.body = "Hurry Up Hurry Up"
        content.sound = .criticalSoundNamed(UNNotificationSoundName(rawValue: "wakeup.mp3"), withAudioVolume: 1)
        
        // Create a date based on the selected hour and minute
        var dateComponents = DateComponents()
        dateComponents.hour
        dateComponents.minute = minute
        dateComponents.second = second
        
        // Create a trigger based on the date
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Create a request with the content and trigger
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
//        callTheAlart()
        
    }
    
//    private func callTheAlart(){
//        // Show success message using UIAlertController
//        let alert = UIAlertController(title: "Successfull", message: "Alarm successfully set!", preferredStyle: .alert)
//        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
//        alert.addAction(okayAction)
//
//        // Present the alert
//        if let VC = UIApplication.shared.windows.first?.rootViewController {
//            VC.present(alert, animated: true, completion: nil)
//        }
//    }
    
}
