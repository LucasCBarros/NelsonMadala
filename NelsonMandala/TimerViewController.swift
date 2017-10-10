//
//  ViewController.swift
//  timertest
//
//  Created by Ricardo Ferreira on 09/10/17.
//  Copyright © 2017 Ricardo Ferreira. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    var seconds = 0
    var timer = Timer()
    var timerIsOn = false
    
    @IBAction func startButton(_ sender: Any) {
        if !timerIsOn{
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
            
            startButton.isEnabled = false
            pauseButton.isEnabled = true
            timerIsOn = true
        }
    }
    
    @IBAction func stopButton(_ sender: Any) {
        timer.invalidate()
        timerIsOn = false
        seconds = 0
        timerLabel.text = "\(seconds)"
        
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        timer.invalidate()
        timerIsOn = false
    }
    
    func updateTimer(){
        seconds += 1
        timerLabel.text = "\(seconds)"
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = "\(seconds)"
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

