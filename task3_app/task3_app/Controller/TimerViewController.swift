//
//  ViewController.swift
//  task3_app
//
//  Created by Mesut Gedik on 1.09.2023.
//

import UIKit

class TimerViewController: UIViewController {

    private let timerManager = TimerManager()
    
    var timer : Timer?
    var isTimerRunning = false
    var remainingTime: TimeInterval = 0
    
    private let datePicker: UIPickerView = {
        var picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let countDownLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label
        label.text = "11:11"
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
        button.addTarget(self, action: #selector(setButtonTapped), for: .primaryActionTriggered)
        
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
        view.addSubviews(datePicker,countDownLabel,timerButton,setResetButton)
      
        view.backgroundColor = .systemBackground
        datePicker.delegate = self
        datePicker.dataSource = self
//        updateCountdownLabel()
        
    }
    private func layout() {
        // datePicker
        NSLayoutConstraint.activate([
//            datePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            datePicker.heightAnchor.constraint(equalToConstant: 175),
            datePicker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            datePicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            datePicker.bottomAnchor.constraint(equalTo: countDownLabel.topAnchor, constant: -20)
            
        ])
        // countDownLabel
        NSLayoutConstraint.activate([
            countDownLabel.heightAnchor.constraint(equalToConstant: 100),
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
    @objc func setButtonTapped(){
        
    }
//
//    func updateCountdownLabel() {
//            let minutes = Int(remainingTime) / 60
//            let seconds = Int(remainingTime) % 60
//            countDownLabel.text = String(format: "%02d:%02d", minutes, seconds)
//        }
//    @objc func stopButtonTapped (){
//        SoundManager.shared.stopAlarmSound()
//        stopButton.isHidden = true
//    }
//    public func makeStopButtonVisible(_ isVisible: Bool){
//        stopButton.isHidden = isVisible
//    }
    
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


