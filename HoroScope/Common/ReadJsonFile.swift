//
//  ReadJsonFile.swift
//  HoroScope
//
//  Created by Luy Nguyen on 3/1/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit
import SwiftyJSON

class ReadJsonFile: NSObject {
    static let shared = ReadJsonFile()
    
    func checkLove(zodiac1: String, zodiac2: String, success:@escaping (String) -> ()) {
        if let path = Bundle.main.path(forResource: "\(zodiac1.lowercased())_\(zodiac2.lowercased())", ofType: "json") {
            do {
                let jsonString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                let json = JSON(parseJSON: jsonString)
                print(json)
                success(json["content"].stringValue)
            } catch {
                print("Can't read json file")
            }
        }
    }
}

let readJsonShared = ReadJsonFile.shared
