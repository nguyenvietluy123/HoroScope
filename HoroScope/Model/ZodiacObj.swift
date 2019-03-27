//
//  ZodiacObj.swift
//  HoroScope
//
//  Created by Luy Nguyen on 3/18/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit
import SwiftyJSON

class Content: NSObject {
    var title: String = ""
    var content: String = ""
    override init() {
        super.init()
    }
    init(data: JSON) {
        self.title = data["title"].stringValue
        self.content = data["content"].stringValue
    }
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
}

class ZodiacObj: NSObject {
    var name: String = ""
    var date: String = ""
    var img: UIImage = UIImage()
    
    var content: [Content] = []
    var today: Content = Content()
    var week: Content = Content()
    var month: Content = Content()
    var year: Content = Content()
    
    override init() {
        super.init()
    }
    
    init(name: String, date: String, img: UIImage) {
        self.name = name
        self.date = date
        self.img = img
    }
}
