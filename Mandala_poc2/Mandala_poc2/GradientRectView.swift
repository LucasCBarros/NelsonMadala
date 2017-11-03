//
//  GradientRectView.swift
//  Mandala_poc2
//
//  Created by Lucas Barros on 31/10/17.
//  Copyright © 2017 Lucas Barros. All rights reserved.
//

import UIKit

class GradientRectView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let locations: [CGFloat] = [ 0.0, 1.0 ]
        let colorspace = CGColorSpaceCreateDeviceRGB()
        // first rectangle
        let context = UIGraphicsGetCurrentContext()
        let colors = [UIColor.blue.cgColor, UIColor.red.cgColor]
        let gradient = CGGradient(colorsSpace: colorspace, colors: colors as CFArray, locations: locations)
        
        var startPoint1 = CGPoint.zero
        var endPoint1 = CGPoint.zero
//        startPoint1.x = 0.0
//        startPoint1.y = 10.0
//        endPoint1.x = 100
//        endPoint1.y = 10
        
        startPoint1.x = 10.0
        startPoint1.y = 0
        endPoint1.x = 10
        endPoint1.y = 100
 
        context?.clip()
        context?.drawLinearGradient(gradient!, start: startPoint1, end: endPoint1, options: .drawsAfterEndLocation)
        
    }
    

}
