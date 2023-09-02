//
//  ViewController.swift
//  task3_app
//
//  Created by Mesut Gedik on 1.09.2023.
//

import UIKit

final class TimerViewController: UIViewController {

    private var timerViewModel = TimerViewModel()

    private let timerManager = TimerManager()
    
    var timer : Timer?
    
    var selectedMinute: Int = 0
    var selectedSecond: Int = 0
    
    private let timePicker: UIPickerView = {
        var picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let countDownLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Light", size: 33)
        label.textAlignment = .center
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1.5
        label.text = ""
        return label
    } ()
    
    private let timerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGreen
        button.setTitle("Play/Pause", for: [])
        button.addTarget(self, action: #selector(playPauseTapped), for: .primaryActionTriggered)
        
        return button
    }()
    
    private let setResetButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray2
        button.setTitle("Set/Reset", for: [])
        button.addTarget(self, action: #selector(setButtonTapped), for: .primaryActionTriggered)
        
        return button
    }()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    private func setup (){
        view.addSubviews(timePicker,countDownLabel,timerButton,setResetButton)
      
        view.backgroundColor = .systemBackground
        timePicker.delegate = self
        timePicker.dataSource = self
        updateCountdownLabel()
    }
    private func layout() {
        // datePicker
        NSLayoutConstraint.activate([
//            datePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            timePicker.heightAnchor.constraint(equalToConstant: 175),
            timePicker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            timePicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            timePicker.bottomAnchor.constraint(equalTo: countDownLabel.topAnchor, constant: -20)
            
        ])
        // countDownLabel
        NSLayoutConstraint.activate([
            countDownLabel.heightAnchor.constraint(equalToConstant: 60),
            countDownLabel.widthAnchor.constraint(equalToConstant: 100),
            countDownLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            countDownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
        // timerButton
        NSLayoutConstraint.activate([
            timerButton.heightAnchor.constraint(equalToConstant: 50),
            timerButton.topAnchor.constraint(equalTo: countDownLabel.bottomAnchor, constant: 50),
            timerButton.leftAnchor.constraint(equalTo: countDownLabel.leftAnchor, constant: -50),
            timerButton.rightAnchor.constraint(equalTo: countDownLabel.rightAnchor, constant: 50)
        ])
        // setResetButton
        NSLayoutConstraint.activate([
            setResetButton.heightAnchor.constraint(equalToConstant: 50),
            setResetButton.topAnchor.constraint(equalTo: timerButton.bottomAnchor, constant: 50),
            setResetButton.leftAnchor.constraint(equalTo: countDownLabel.leftAnchor, constant: -50),
            setResetButton.rightAnchor.constraint(equalTo: countDownLabel.rightAnchor, constant: 50)
        ])
    }

}
// MARK: - Actions
extension TimerViewController{
    
    @objc func playPauseTapped(){
        
        switch timerViewModel.timerModel.timerState {
        case .stopped: //first start
            timerViewModel.timerModel.timerState = .running
            timerViewModel.startTimer(withMinutes: selectedMinute, seconds: selectedSecond)
            startTimer()
        case .running: // to pause
            pauseTimer()
        case .paused: // to start after pause
            timerViewModel.timerModel.timerState = .running
            startTimer()
        }
        
    }
    
    @objc func setButtonTapped(){
        timerViewModel.stopTimer()
        timePicker.selectRow(0, inComponent: 0, animated: true)
        timePicker.selectRow(0, inComponent: 1, animated: true)
        updateCountdownLabel()
        selectedMinute = 0
        selectedSecond = 0
    }
    private func startTimer(){
        timerButton.setTitle("Pause", for: .normal)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        setResetButton.isEnabled = false
        
    }
    
    @objc func updateTimer() {
        if timerViewModel.timerModel.remainingTime <= 0 {
            SoundManager.shared.playAlarmSound()
//            print("who let the dogs out, who?")

            DispatchQueue.main.async {
//                print("who let the dogs out, who?")
//                self.timerManager.callTheCops()
            }
            stopTimer()
            
        }
        timerViewModel.updateTimer()
        updateCountdownLabel()
    }
    
    private func pauseTimer(){
        timerButton.setTitle("Play", for: .normal)
        timerViewModel.pauseTimer()
        timer?.invalidate()
        setResetButton.isEnabled = true
    }
    
    private func stopTimer() {
        timerButton.setTitle("Play", for: .normal)
        timerViewModel.stopTimer()
        timer?.invalidate()
        setResetButton.isEnabled = true
    }
    
    private func updateCountdownLabel() {
            let minutes = Int(timerViewModel.timerModel.remainingTime) / 60
            let seconds = Int(timerViewModel.timerModel.remainingTime) % 60
            countDownLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
}
// MARK: - PickerView Delegate and DataSourse
extension TimerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? timerManager.minuteArray.count : timerManager.secondArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            let minute = timerManager.minuteArray[row] < 10 ? "0\(timerManager.minuteArray[row])" : "\(timerManager.minuteArray[row])"
            return minute
        } else {
            let second = timerManager.secondArray[row] < 10 ? "0\(timerManager.secondArray[row])" : "\(timerManager.secondArray[row])"
            return second
        }
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 70
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }

}

// MARK: - Start/Pause Button Storing the Time
extension TimerViewController{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedMinute = timerManager.minuteArray[row]
        } else{
            selectedSecond = timerManager.secondArray[row]
        }
        updateCountdownLabel()
    }
}



