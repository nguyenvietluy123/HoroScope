//
//  Parse.swift
//  HoroScope
//
//  Created by Luy Nguyen on 3/20/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit
import SwiftyJSON

class Parse: NSObject {
    static let shared = Parse()
    override init() {
        super.init()
    }
  
//    func parseListContent(data: JSON) -> String {
//        var items: [LocalityObj] = []
//        for json in data["card"].arrayValue {
//            let item = LocalityObj(data: json)
//            items.append(item)
//        }
//        return items
//    }
}

let parseShared = Parse.shared
