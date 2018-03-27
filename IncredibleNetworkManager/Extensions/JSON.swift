//
//  JSON.swift
//  Pods
//
//  Created by Fabio Gustavo Hoffmann on 25/03/18.
//

import UIKit

extension Dictionary {
    public func parseDouble(key: String) -> Double {
        return Parser.doubleValue(self as? [String: Any] ?? [:], key: key)
    }

    public func parseInt(key: String) -> Int {
        return Parser.intValue(self as? [String: Any] ?? [:], key: key)
    }

    public func parseBool(key: String) -> Bool {
        return Parser.boolValue(self as? [String: Any] ?? [:], key: key)
    }

    public func parseString(key: String) -> String {
        return Parser.stringValue(self as? [String: Any] ?? [:], key: key)
    }

    public func parseDate(key: String, format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> Date? {
        return Parser.dateValue(self as? [String: Any] ?? [:], key: key, format: format)
    }

    public func parseColor(key: String) -> UIColor {
        return Parser.colorValue(self as? [String: Any] ?? [:], key: key)
    }
}
