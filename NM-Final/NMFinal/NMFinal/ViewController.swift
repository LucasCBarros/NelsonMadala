//
//  ViewController.swift
//  NMFinal
//
//  Created by Rhullian Damião on 10/10/2017.
//  Copyright © 2017 Rhullian Damião. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    var currentTime = 0.0
    var totalTime = 0.0 // Tempo do mandala
    var timer:Timer?
    var procrastinationTimer:Timer?
    var isRunning = true
    let frameDuration = 0.01
    
    @IBOutlet var mandalaImage: mandalaView!
    
    var click = 0
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet var mandalaView: mandalaView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var typeSelectedLabel: UILabel!
    
    //Numero de copias da linha no circulo
    var numCopy:Int = 0
    // Height define comprimento
    var randomHeight:CGFloat = 0.0
    // Width define espessura
    var randomWidth:CGFloat = 0.0
    // Y define distancia pra dentro ou para fora da View que contem o circulo
    var randomDist:CGFloat = 0.0
    // X define o angulo do traço
    var randomSize:CGFloat = 0.0
    // Line color
    var randomLineColor = UIColor.black
    // View Base
    let someView = UIView(frame: CGRect(x: 0, y: 160, width: 415, height: 415))
    // Cria o replicador
    let replicatorLayer = CAReplicatorLayer()
    
    // Count do que ??? >>> Tempo dos timers?
    var count:Int = 0
    
    func randomColor()->UIColor{
        let color = arc4random_uniform(8)
        switch color {
        case 0:
            return UIColor.orange
//        case 1:
//            return UIColor.blue
        case 2:
            return UIColor.red
        case 3:
            return UIColor.green
        case 4:
            return UIColor.cyan
        case 5:
            return UIColor.yellow
        case 6:
            return UIColor.magenta
        case 7:
            return UIColor.white
        case 8:
            return UIColor.gray
        default:
            return UIColor.black
        }
    }
    
    func randomParameters(){
        //Numero de eixo copiados
        self.numCopy = Int(arc4random_uniform(45) + 15)
        // Height define comprimento
        self.randomHeight = CGFloat(arc4random_uniform(400)+10)
        // Width define espessura
        self.randomWidth = CGFloat(arc4random_uniform(5)+2) //arc4random_uniform(MAX)+ MIN
        // Y define distancia pra dentro ou para fora da View que contem o circulo
        self.randomDist = CGFloat(arc4random_uniform(15)+2)
        // X define o angulo do traço
        self.randomSize = CGFloat(Double(arc4random_uniform(209))+0.5)
        // Line color
        self.randomLineColor = randomColor()
    }
    
    func createRandomLines(){
        randomParameters()
        
        replicatorLayer.frame = mandalaView.bounds
        
        replicatorLayer.instanceCount = numCopy// Altera numero de imagens no circulo
        replicatorLayer.instanceDelay = CFTimeInterval(1 / 30)
        replicatorLayer.preservesDepth = false
        replicatorLayer.instanceColor = randomLineColor.cgColor
        
        let angle = Float(Double.pi * 2.0) / Float(numCopy) // Altera numero de imagens no circulo
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0.0, 0.0, 1.0)
        mandalaView.layer.addSublayer(replicatorLayer)
        
        let instanceLayer = CALayer()
        let width = mandalaView.bounds.width
        instanceLayer.frame = CGRect(x: randomSize, y: width/randomDist, width: randomWidth, height: randomHeight)
        instanceLayer.backgroundColor = UIColor.white.cgColor
        replicatorLayer.addSublayer(instanceLayer)
    }
    
    func createMandala(){
        
        self.mandalaView.backgroundColor = UIColor.blue //randomColor()
        view.addSubview(mandalaView)
        
        let lineNum = arc4random_uniform(4)+2
        
        // Gera qnt aleatoria de linhas
        for _ in 2 ..< lineNum {
            createRandomLines()
        }
        
        startButton.isHidden = true
        timerLabel.isHidden = true
        typeSelectedLabel.isHidden = true
        pauseButton.isHidden = false
        stopButton.isHidden = false
        mandalaImage.isHidden = false
        
        if isRunning {
            pauseDrawing()
        } else {
            unpauseDrawing()
        }
    }
    
    @IBAction func clickPause(_ sender: Any) {
        if isRunning {
            pauseDrawing()
        } else {
            unpauseDrawing()
        }
        
        if(click==0){
            pauseButton.setBackgroundImage(nil, for: .normal)
            pauseButton.setTitle("Return .", for: .normal)
            click=1
        } else {
            pauseButton.setBackgroundImage(#imageLiteral(resourceName: "buttonBackground"), for: .normal)
            pauseButton.setTitle("Pause  .", for: .normal)
            click=0
        }
    }
    
    @IBAction func clickStop(_ sender: Any) {

        isRunning = false
        timer?.invalidate()
        // Starts the vibration alert timer
        vibrationAlert()
        
        replicatorLayer.isHidden = true
        pauseButton.isHidden = true
        stopButton.isHidden = true
        startButton.isHidden = false
        timerLabel.isHidden = false
        typeSelectedLabel.isHidden = false
        mandalaImage.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pauseButton.layer.cornerRadius = pauseButton.frame.height/2
        pauseButton.clipsToBounds = true
        pauseButton.isHidden = true
        stopButton.layer.cornerRadius = stopButton.frame.height/2
        stopButton.clipsToBounds = true
        stopButton.isHidden = true
        mandalaImage.isHidden = true
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Funcao que seta o tempo de musica
    @IBAction func setMusicTime(_ sender: UIButton) {
        self.typeSelectedLabel.text = "Music Timer"
        totalTime = 240
        self.count = 240
        setTimerLabel()
    }
    
    // Funcao que seta o tempo de estudo
    @IBAction func setStudyTime(_ sender: UIButton) {
        self.typeSelectedLabel.text = "Study Timer"
        totalTime = 120
        self.count = 120
        setTimerLabel()
    }
    
    // Funcao que seta o tempo de jogo
    @IBAction func setGameTime(_ sender: Any) {
        self.typeSelectedLabel.text = "Game Timer"
        totalTime = 360
        self.count = 360
        setTimerLabel()
    }
    
    // Funcao que inicializa o timer
    @IBAction func startStopTimer(_ sender: UIButton) {
        
        var timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startCounting), userInfo: nil, repeats: true)
        
        self.timer = Timer.scheduledTimer(timeInterval: frameDuration, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        isRunning = true
//        mandalaImage.calculateProportion(currentTime: currentTime, totalTime: totalTime)
        
        replicatorLayer.isHidden = false
        createMandala()
        
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
            return String(count/60)
        }
        else{
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

    @objc func updateTimer(){
        if (UIDevice.current.proximityState) {
            if currentTime <= totalTime {
                mandalaImage.calculateProportion(currentTime: currentTime, totalTime: totalTime)
                currentTime += frameDuration
            } else {
                isRunning = false
                timer?.invalidate()
            }
        }
    }
    
    @objc func vibrationAlert(){
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    func pauseDrawing() {
        isRunning = false
        timer?.invalidate()
        
        // Starts the vibration alert timer
        vibrationAlert()
        procrastinationTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: (#selector(ViewController.vibrationAlert)), userInfo: nil, repeats: true)
    }
    
    func unpauseDrawing() {
        isRunning = true
        if currentTime > totalTime {
            self.dismiss(animated: false, completion: nil)
        }
        procrastinationTimer?.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: frameDuration, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }

}

