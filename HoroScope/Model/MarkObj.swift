//
//  MarkObj.swift
//  HoroScope
//
//  Created by Luy Nguyen on 3/17/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class MarkObj: NSObject {
    var title: String = ""
    var imgMain: UIImage = UIImage()
    var scoreLeft: Double = 0
    var scoreRight: Double = 0
    
    override init() {
        super.init()
    }
    
    init(title: String, imgMain: UIImage, scoreLeft: Double, scoreRight: Double) {
        self.title = title
        self.imgMain = imgMain
        self.scoreLeft = scoreLeft
        self.scoreRight = scoreRight
    }
}
