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
    
    func getContentZodiac(zodiac: ZodiacObj, success: @escaping () -> ()) {
        if let path = Bundle.main.path(forResource: zodiac.name.lowercased(), ofType: "json") {
            do {
                let jsonString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                let data = JSON(parseJSON: jsonString)
                zodiac.content.removeAll()
                for json in data["card"].arrayValue {
                    let item = Content(data: json)
                    zodiac.content.append(item)
                }
                success()
            } catch {
                print("Can't read json file")
            }
        }
    }
    
    func checkLove(resource: String, success: @escaping (String) -> ()) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
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
