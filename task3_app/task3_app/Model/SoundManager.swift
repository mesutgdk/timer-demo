//
//  SoundManager.swift
//  task3_app
//
//  Created by Mesut Gedik on 2.09.2023.
//

import UIKit
import AVFoundation

final class SoundManager {
    static let shared = SoundManager()
    
    var player: AVAudioPlayer?
    var volumeTimer: Timer?
    let maxVolume: Float = 1.0
    let duration: TimeInterval = 30.0
    
    private init() {
    }
    
    func playAlarmSound() {
        guard let audioFilePath = Bundle.main.path(forResource: "wakeup", ofType: "mp3") else {
            return
        }
        let audioFileURL = URL(fileURLWithPath: audioFilePath)
        
        do {
            player = try AVAudioPlayer(contentsOf: audioFileURL)
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("Error playing alarm sound: \(error.localizedDescription)")
        }
        callTheAlart()
    }

    private func stopAlarmSound(){
        player?.stop()
    }

    private func callTheAlart(){
        // Show success message using UIAlertController
        let alert = UIAlertController(title: "Time out", message: "End of the Road", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Silence! Kill You!", style: .default) { (okayAction) in
            self.stopAlarmSound()
        }
        alert.addAction(okayAction)
        
        // Present the alert
        if let VC = UIApplication.shared.windows.first?.rootViewController {
            VC.present(alert, animated: true, completion: nil)
        }
    }

}
