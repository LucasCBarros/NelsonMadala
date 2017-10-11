//
//  mandalaView.swift
//  viewMandala
//
//  Created by Lucas Santos on 09/10/17.
//  Copyright © 2017 lucasSantos. All rights reserved.
//

import UIKit

@IBDesignable class MandalaView : UIView {
    
    
 var proportion = 0.5

    public func calculateProportion(currentTime: TimeInterval, totalTime: TimeInterval){
        proportion = min(1, currentTime / totalTime)
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        
        print("draw")
        
        let _ : CGContext! = UIGraphicsGetCurrentContext()

        let rectCenter = CGPoint(x: rect.origin.x + rect.size.width/2, y: rect.origin.y + rect.size.height/2)
        
        let pathComplete = UIBezierPath(arcCenter: rectCenter, radius: rect.width / 2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        //context.setLineWidth(100.0)
        UIColor.white.setStroke()
        pathComplete.lineWidth = rect.width * CGFloat(1-proportion)
        
        pathComplete.stroke()
        
        //pathComplete.addClip()
        //pathComplete.fill(with: .clear, alpha: 1)
    }
    
}

