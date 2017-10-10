//
//  mandalaView.swift
//  NMFinal
//
//  Created by Rhullian Damião on 10/10/2017.
//  Copyright © 2017 Rhullian Damião. All rights reserved.
//

import UIKit

@IBDesignable
class mandalaView: UIView {

    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.masksToBounds = true
    }
}
