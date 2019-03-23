//
//  API.swift
//  HMKFieldCollector
//
//  Created by Luy Nguyen on 11/21/18.
//  Copyright © 2018 Hoa. All rights reserved.
//

import Foundation

enum APIType {
    case dev, live
}

class APIFinal {
    var mainAPI: String
    var user: String
    var pass: String
    
    static let shared = APIFinal()
    
    private init() {
        mainAPI = "http://115.79.35.119:9008/api/hmk/"
        user = "toan.huynh"
        pass = "a"
    }
    
    func config(_ type: APIType) {
        switch type {
        case .dev:
            mainAPI = "http://115.79.35.119:9008/api/hmk/"
            user = "toan.huynh"
            pass = "a"
            break
            
        case .live:
            mainAPI = "http://115.79.35.119:9008/api/hmk/"
            user = "vuong.ho"
            pass = "a"
            break
        }
    }
}

let apiFinalShared = APIFinal.shared
let mainAPI = apiFinalShared.mainAPI
