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
    let mainApi: String = "http://horoscope-api.herokuapp.com/horoscope/"
//    http://horoscope-api.herokuapp.com/horoscope/year/Libra
    override init() {
        super.init()
    }
    
    func getDataZodiac(zodiac: ZodiacObj, success: @escaping () -> ()) {
        let url1 = "\(mainApi)\(TimeType.today)/\(zodiac.name)"
        apiRequestShared.webServiceCall(url1, params: nil, isShowLoader: true, method: .get, isHasHeader: false) { (response) in
            zodiac.today.title = response.responeJson["date"].stringValue
            zodiac.today.content = response.responeJson["horoscope"].stringValue
            self.haveToday = true
            if self.haveToday && self.haveWeek && self.haveMonth && self.haveYear {
                success()
                self.initCondition()
            }
        }
        
        let url2 = "\(mainApi)\(TimeType.week)/\(zodiac.name)"
        apiRequestShared.webServiceCall(url2, params: nil, isShowLoader: true, method: .get, isHasHeader: true) { (response) in
            zodiac.week.title = response.responeJson["week"].stringValue
            zodiac.week.content = response.responeJson["horoscope"].stringValue
            self.haveWeek = true
            if self.haveToday && self.haveWeek && self.haveMonth && self.haveYear {
                success()
                self.initCondition()
            }
        }

        let url3 = "\(mainApi)\(TimeType.month)/\(zodiac.name)"
        apiRequestShared.webServiceCall(url3, params: nil, isShowLoader: true, method: .get, isHasHeader: true) { (response) in
            zodiac.month.title = response.responeJson["month"].stringValue
            zodiac.month.content = response.responeJson["horoscope"].stringValue
            self.haveMonth = true
            if self.haveToday && self.haveWeek && self.haveMonth && self.haveYear {
                success()
                self.initCondition()
            }
        }

        let url4 = "\(mainApi)\(TimeType.year)/\(zodiac.name)"
        apiRequestShared.webServiceCall(url4, params: nil, isShowLoader: true, method: .get, isHasHeader: true) { (response) in
            zodiac.year.title = response.responeJson["year"].stringValue
            zodiac.year.content = response.responeJson["horoscope"].stringValue
            self.haveYear = true
            if self.haveToday && self.haveWeek && self.haveMonth && self.haveYear {
                success()
                self.initCondition()
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
