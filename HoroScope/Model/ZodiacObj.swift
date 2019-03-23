//
//  ZodiacObj.swift
//  HoroScope
//
//  Created by Luy Nguyen on 3/18/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Content {
    var title: String = ""
    var content: String = ""
    
    init(data: JSON) {
        self.title = data["title"].stringValue
        self.content = data["content"].stringValue
    }
}

class ZodiacObj: NSObject {
    var name: String = ""
    var date: String = ""
    var img: UIImage = UIImage()
    
    var content: [Content] = []
    var today: String = ""
    var week: String = ""
    var month: String = ""
    var year: String = ""
    
    override init() {
        super.init()
    }
    
    init(name: String, date: String, img: UIImage) {
        self.name = name
        self.date = date
        self.img = img
    }
}
