//
//  ViewController.swift
//  timertest
//
//  Created by Ricardo Ferreira on 09/10/17.
//  Copyright © 2017 Ricardo Ferreira. All rights reserved.
//

import UIKit

class MandalaViewController: UIViewController {
    
    let frameDuration = 0.01
    
    @IBOutlet weak var mandalaImage: MandalaView!
    
    var currentTime = 0.0
    var totalTime = 0.0
    
    @objc func updateTimer(){
        mandalaImage.calculateProportion(currentTime: currentTime, totalTime: totalTime)
        currentTime += frameDuration
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: frameDuration, target: self, selector: (#selector(MandalaViewController.updateTimer)), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

