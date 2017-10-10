//
//  ViewController.swift
//  NMFinal
//
//  Created by Rhullian Damião on 10/10/2017.
//  Copyright © 2017 Rhullian Damião. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!

    @IBOutlet weak var typeSelectedLabel: UILabel!
    
    var count:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Funcao que seta o tempo de estudo de musica
    @IBAction func setMusicTime(_ sender: UIButton) {
        self.typeSelectedLabel.text = "Music Timer"
        self.count = 240
        setTimerLabel()
    }
    
    // funcao que seta o tempo de estudo
    @IBAction func setStudyTime(_ sender: UIButton) {
        self.typeSelectedLabel.text = "Study Timer"
        self.count = 120
        setTimerLabel()
    }
    
    @IBAction func setGameTime(_ sender: Any) {
        self.typeSelectedLabel.text = "Game Timer"
        self.count = 360
        setTimerLabel()
    }
    
    //Funcao que inicializa o timer
    @IBAction func startStopTimer(_ sender: UIButton) {
        var timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startCounting), userInfo: nil, repeats: true)
    }
    
    //contador
    @objc func startCounting(){
        if count>0{
            setTimerLabel()
            count-=1
        }
    }
    
    //Funcao que seta a label
    func setTimerLabel(){
        let minutes = checkMinutes()
        let seconds = checkSeconds()
        self.timerLabel.text = minutes+":"+seconds
    }
    
    func checkMinutes()->String{
        if (count/60) > 10{
            print(count/60)
            return String(count/60)
        }
        else{
            print(count/60)
            return "0"+String(count/60)
        }
        
    }
    
    func checkSeconds()->String{
        if (count%60) > 10{
            
            return String(count%60)
        }
        else{
            
            return "0"+String(count%60)
        }
        
    }
}

