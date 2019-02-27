//
//  SaveHelper.swift
//  Task
//
//  Created by Hoa on 3/31/18.
//  Copyright © 2018 SDC. All rights reserved.
//
import Foundation

class SaveHelper {
    static func save(_ object: Any, key: SaveKey) {
        standard().set(object, forKey: key.rawValue)
        sync()
    }
    
    static func get(_ key: SaveKey) -> Any {
        let value = standard().object(forKey: key.rawValue)
        guard value == nil else {
            return value as AnyObject
        }
        return ""
    }
    
    static func delete(key: SaveKey) {
        standard().removeObject(forKey: key.rawValue)
        sync()
    }
    
    
    static func unarchive(key: SaveKey) -> AnyObject? {
        if let data = get(key) as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: data) as AnyObject
        } else {
            return nil
        }
    }
    
    static func archive(object: AnyObject, key: SaveKey) {
        let data = NSKeyedArchiver.archivedData(withRootObject: object) as AnyObject
        save (data, key: key)
    }
    
    
    // MARK: Helpers
    
    static func standard() -> UserDefaults {
        return UserDefaults.standard
    }
    
    static func sync() {
        standard().synchronize()
    }
}
