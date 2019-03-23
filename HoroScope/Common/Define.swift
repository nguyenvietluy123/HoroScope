//
//  Define.swift
//  Carenefit
//
//  Created by Tony Tuan on 9/4/17.
//  Copyright © 2017 sdc. All rights reserved.
//

import UIKit

let isIPad = DeviceType.IS_IPAD
let heightRatio = (isIPad) ? 1.4 : ScreenSize.SCREEN_HEIGHT/736
let widthRatio = (isIPad) ? 1.4 : ScreenSize.SCREEN_WIDTH/414
let heightDetailCell = (isIPad) ? 55 : 40*heightRatio
let timeZoneApp = 7*60*60
let ctrTopCellDetail = (isIPad) ? 20 : 15*heightRatio
let heightCellContact = (isIPad) ? 60 : 45*heightRatio
let heightTitleCollapse = (isIPad) ? 70 : 50*heightRatio

enum typeTemp {
    case tempC
    case tempF
}

enum SaveKey: String {
    case deviceToken = "deviceToken"
    case tokenType = "tokenType"
    case accessToken = "accessToken"
    case email = "email"
    case pass = "pass"
    case isLogin = "isLogin"
}

enum Zodiac: String {
    case Aquarius = "Aquarius"
    case Pisces = "Pisces"
    case Aries = "Aries"
    case Taurus = "Taurus"
    case Gemini = "Gemini"
    case Cancer = "Cancer"
    case Leo = "Leo"
    case Virgo = "Virgo"
    case Libra = "Libra"
    case Scorpio = "Scorpio"
    case Sagittarius = "Sagittarius"
    case Capricorn = "Capricorn"
}

enum ZodiacDate: String {
    case Aquarius = "20/01 ~ 18/02"
    case Pisces = "19/02 ~ 20/03"
    case Aries = "21/03 ~ 20/04"
    case Taurus = "21/04 ~ 20/05"
    case Gemini = "21/05 ~ 21/06"
    case Cancer = "22/06 ~ 22/07"
    case Leo = "23/07 ~ 22/08"
    case Virgo = "23/08 ~ 22/09"
    case Libra = "23/09 ~ 22/10"
    case Scorpio = "23/10 ~ 21/11"
    case Sagittarius = "22/11 ~ 21/12"
    case Capricorn = "22/12 ~ 19/01"
}

enum TimeType: String {
    case general = "general"
    case today = "today"
    case week = "week"
    case month = "month"
    case year = "year"
}

class NotificationCenterKey {
    static let SelectedMenu = "SelectedMenu"
    static let DismissAllAlert = "DismissAllAlert"
    static let CantDetectFace = "CantDetectFace"
    static let ReloadData = "ReloadData"
    static let ShowZodiacsVC = "ShowZodiacsVC"
}

class Key {
    static let keyMap = "AIzaSyDqXq6POMT9b3bjBqWVYnVRhD_EcSE01-4"
}

class TColor {
    static let pinkColor = UIColor("D31F46", alpha: 1.0)
    static let greenMainColor = UIColor("00868A", alpha: 1.0)
    static let blackBorderTFColor = UIColor("1D1D26", alpha: 0.1)
    static let blackToolBarColor = UIColor("4F4E4F", alpha: 1.0)
    static let blueBorderCLColor = UIColor("4A90E2", alpha: 1.0)
    static let grayCellColor = UIColor("f1f1f1", alpha: 1.0)
    static let greenMenuSelectedColor = UIColor("C9E5E6", alpha: 1.0)
    static let redMenuSelectedColor = UIColor("A72835", alpha: 1.0)
    static let yellowBackgroundCell = UIColor("fffed1", alpha: 1.0)
}

protocol EnumCollection : Hashable {}
extension EnumCollection {
    static func cases() -> AnySequence<Self> {
        typealias S = Self
        return AnySequence { () -> AnyIterator<S> in
            var raw = 0
            return AnyIterator {
                let current : Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: S.self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else { return nil }
                raw += 1
                return current
            }
        }
    }
}
