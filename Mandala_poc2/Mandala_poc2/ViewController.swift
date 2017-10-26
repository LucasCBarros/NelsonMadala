//
//  ViewController.swift
//  Mandala_poc2
//
//  Created by Lucas Barros on 24/10/17.
//  Copyright © 2017 Lucas Barros. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Vetor replicador
    
    //Numero de copias
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
    
    func randomColor()->UIColor{
        let color = arc4random_uniform(8)
        switch color {
        case 0:
            return UIColor.orange
        case 1:
            return UIColor.blue
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
        //Numero de copias
        self.numCopy = Int(arc4random_uniform(100) + 15)
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
        
        replicatorLayer.frame = someView.bounds
        
        replicatorLayer.instanceCount = numCopy// Altera numero de imagens no circulo
        replicatorLayer.instanceDelay = CFTimeInterval(1 / 30)
        replicatorLayer.preservesDepth = false
        replicatorLayer.instanceColor = randomLineColor.cgColor
        
        let angle = Float(Double.pi * 2.0) / Float(numCopy) // Altera numero de imagens no circulo
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0.0, 0.0, 1.0)
        someView.layer.addSublayer(replicatorLayer)
        
        let instanceLayer = CALayer()
        let width = someView.bounds.width
        instanceLayer.frame = CGRect(x: randomSize, y: width/randomDist, width: randomWidth, height: randomHeight)
        instanceLayer.backgroundColor = UIColor.white.cgColor
        replicatorLayer.addSublayer(instanceLayer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.someView.backgroundColor = randomColor()
        view.addSubview(someView)
        
        let lineNum = arc4random_uniform(4)+2
        
        // Gera qnt aleatoria de linhas
        for _ in 2 ..< lineNum {
           createRandomLines()
        }
        
        
        /*
//        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
//        fadeAnimation.fromValue = 1.0
//        fadeAnimation.toValue = 0.0
//        fadeAnimation.duration = 1
//        fadeAnimation.repeatCount = Float.greatestFiniteMagnitude
//        
//        instanceLayer.opacity = 0.0
//        instanceLayer.add(fadeAnimation, forKey: "FadeAnimation")
//        instanceLayer2.opacity = 0.0
//        instanceLayer2.add(fadeAnimation, forKey: "FadeAnimation")
//        instanceLayer3.opacity = 0.0
//        instanceLayer3.add(fadeAnimation, forKey: "FadeAnimation")
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


