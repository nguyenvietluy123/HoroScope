//
//  ZodiacService.swift
//  HoroScope
//
//  Created by Luy Nguyen on 3/20/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class ZodiacService: NSObject {
    static let shared = ZodiacService()
    
    var haveToday: Bool = false
    var haveWeek: Bool = false
    var haveMonth: Bool = false
    var haveYear: Bool = false
    
    override init() {
        super.init()
    }
    
    func getDataZodiac(zodiac: ZodiacObj, success: @escaping () -> ()) {
        let url1 = "https://horoscope-free-api.herokuapp.com/?time=\(TimeType.today)&sign=\(zodiac.name)"
        apiRequestShared.webServiceCall(url1, params: nil, isShowLoader: true, method: .get, isHasHeader: true) { (response) in
            if response.responeJson["status"] == 200 {
                zodiac.today = response.responeJson["data"].stringValue
                self.haveToday = true
                if self.haveToday && self.haveWeek && self.haveMonth && self.haveYear {
                    success()
                    self.initCondition()
                }
            }
        }
        
        let url2 = "https://horoscope-free-api.herokuapp.com/?time=\(TimeType.week)&sign=\(zodiac.name)"
        apiRequestShared.webServiceCall(url2, params: nil, isShowLoader: true, method: .get, isHasHeader: true) { (response) in
            if response.responeJson["status"] == 200 {
                zodiac.week = response.responeJson["data"].stringValue
                self.haveWeek = true
                if self.haveToday && self.haveWeek && self.haveMonth && self.haveYear {
                    success()
                    self.initCondition()
                }
            }
        }
        
        let url3 = "https://horoscope-free-api.herokuapp.com/?time=\(TimeType.month)&sign=\(zodiac.name)"
        apiRequestShared.webServiceCall(url3, params: nil, isShowLoader: true, method: .get, isHasHeader: true) { (response) in
            if response.responeJson["status"] == 200 {
                zodiac.month = response.responeJson["data"].stringValue
                self.haveMonth = true
                if self.haveToday && self.haveWeek && self.haveMonth && self.haveYear {
                    success()
                    self.initCondition()
                }
            }
        }
        
        let url4 = "https://horoscope-free-api.herokuapp.com/?time=\(TimeType.year)&sign=\(zodiac.name)"
        apiRequestShared.webServiceCall(url4, params: nil, isShowLoader: true, method: .get, isHasHeader: true) { (response) in
            if response.responeJson["status"] == 200 {
                zodiac.year = response.responeJson["data"].stringValue
                self.haveYear = true
                if self.haveToday && self.haveWeek && self.haveMonth && self.haveYear {
                    success()
                    self.initCondition()
                }
            }
        }
    }
    
    func initCondition() {
        haveToday = false
        haveWeek = false
        haveMonth = false
        haveWeek = false
    }
}
