//
//  ViewController.swift
//  timertest
//
//  Created by Ricardo Ferreira on 09/10/17.
//  Copyright © 2017 Ricardo Ferreira. All rights reserved.
//

import UIKit
import AudioToolbox

class MandalaViewController: UIViewController {
    
    let frameDuration = 0.01
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var mandalaImage: MandalaView!
    
    var currentTime = 0.0
    var totalTime = 0.0
    var timer:Timer?
    var procrastinationTimer:Timer?
    var isRunning = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: frameDuration, target: self, selector: (#selector(MandalaViewController.updateTimer)), userInfo: nil, repeats: true)
        isRunning = true
        UIDevice.current.isProximityMonitoringEnabled = true
        mandalaImage.calculateProportion(currentTime: currentTime, totalTime: totalTime)
    }
    
    @objc func updateTimer(){
        if (UIDevice.current.proximityState) {
            if currentTime <= totalTime {
                mandalaImage.calculateProportion(currentTime: currentTime, totalTime: totalTime)
                currentTime += frameDuration
            } else {
                isRunning = false
                timer?.invalidate()
                pauseButton.setTitle("congratulations!", for: .normal)
                pauseButton.backgroundColor = UIColor.init(red: 0, green: 255, blue: 0, alpha: 0.20)
            }
        }
    }
    
    @objc func vibrationAlert(){
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    @IBAction func pauseButtonPressed(_ sender: UIButton) {
        if isRunning {
            pauseDrawing()
        } else {
            unpauseDrawing()
        }
    }
    
    func pauseDrawing() {
        isRunning = false
        timer?.invalidate()
        
        pauseButton.setTitle("commit!", for: .normal)
        pauseButton.backgroundColor = UIColor.init(red: 255, green: 0, blue: 0, alpha: 0.22)
        self.view.backgroundColor = UIColor.black
        
        // Starts the vibration alert timer
        vibrationAlert()
        procrastinationTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: (#selector(MandalaViewController.vibrationAlert)), userInfo: nil, repeats: true)
    }
    
    func unpauseDrawing() {
        isRunning = true
        if currentTime > totalTime {
            self.dismiss(animated: false, completion: nil)
        }
        procrastinationTimer?.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: frameDuration, target: self, selector: (#selector(MandalaViewController.updateTimer)), userInfo: nil, repeats: true)
        pauseButton.setTitle("procrastinate...", for: .normal)
        pauseButton.backgroundColor = UIColor.init(red: 255, green: 255, blue: 0, alpha: 0.22)
        
        self.view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

