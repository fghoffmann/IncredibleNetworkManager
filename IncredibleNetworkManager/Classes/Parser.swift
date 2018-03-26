//
//  Parser.swift
//  Pods
//
//  Created by Fabio Gustavo Hoffmann on 24/03/18.
//

import UIKit

class Parser: NSObject {

    open static func processResponseCode(_ responseObject: Any?, success:()->Void, failure:(_ message: String)->Void) {
        guard let responseObject = responseObject as? [String: AnyObject] else {
            failure("Not a json object")
            return
        }

        print("responseObject: \(responseObject)")
        let code = Parser.stringValue(responseObject, key: "code")
        print("code -> \(code)")
        if code == "200"{
            success()
        }else{
            let result = Parser.stringValue(responseObject, key: "message")
            print(result)
            failure(result)
        }
    }

    open static func processResponseSuccess(_ responseObject: Any?, success:()->Void, failure:(_ message: String?)->Void) {
        guard let responseObject = responseObject as? [String: AnyObject] else {
            failure("Not a json object")
            return
        }

        print("response: \(responseObject)")

        if Parser.boolValue(responseObject, key: "success") {
            success()
        }else{
            let result = Parser.stringValue(responseObject, key: "error")
            print(result)
            failure(result)
        }
    }

    open static func processResponse(_ responseObject: Any?, success:()->Void, failure:(_ message: String?)->Void) {
        guard let responseObject = responseObject as? [String: AnyObject] else {
            failure("Not a json object")
            return
        }

        print("response: \(responseObject)")

        let error = Parser.stringValue(responseObject, key: "error")

        if error.count > 0 {
            var errorResponse = ""
            let errorDescription = Parser.stringValue(responseObject, key: "error_description")
            if errorDescription.count > 0 {
                errorResponse = "Error: \(error) \n Description: \(errorDescription)"
            }else{
                errorResponse = "Error: \(error)"
            }

            failure(errorResponse)

        }else{
            success()
        }

    }

    open static func jsonObject(_ data: Data?) -> AnyObject? {
        if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                return json as AnyObject?
            } catch {
                print("error serializing JSON: \(error)")
            }
        }

        return nil
    }

    open static func doubleValue(_ jsonObject: [String: Any], key: String) -> Double {
        if let value = jsonObject[key] as? Double {
            return value
        }else if let value = jsonObject[key] as? String {
            return Double(value.trimmed) ?? 0
        }else if let array = jsonObject[key] as? [String] {
            return Double(array[0].trimmed) ?? 0
        }
        return 0
    }

    open static func intValue(_ jsonObject: [String: Any], key: String) -> Int {
        if let value = jsonObject[key] as? Int {
            return value
        }else if let value = jsonObject[key] as? String {
            return Int(value.trimmed) ?? 0
        }else if let array = jsonObject[key] as? [String] {
            return Int(array[0].trimmed) ?? 0
        }
        return 0
    }

    open static func boolValue(_ jsonObject: [String: Any], key: String) -> Bool {
        if let value = jsonObject[key] as? Bool {
            return value
        }else if let value = jsonObject[key] as? String {
            return value.trimmed.toBool() ?? false
        }else if let array = jsonObject[key] as? [String] {
            return array[0].trimmed.toBool() ?? false
        }
        return false
    }

    open static func stringValue(_ jsonObject: [String: Any], key: String) -> String {
        if let value = jsonObject[key] as? String {
            return value
        }else if let array = jsonObject[key] as? [String] {
            return array[0]
        }else if let object = jsonObject[key] {
            return "\(object)".removeNull()
        }
        return ""
    }

    open static func dateValue(_ jsonObject: [String: Any], key: String, format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> Date?{
        let dateString = stringValue(jsonObject, key: key)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateString)
    }

    open static func propertyNamesOfObject(_ object: Any) -> [String] {
        return Mirror(reflecting: object).children.filter { $0.label != nil }.map { $0.label! }
    }

    open static func propertyNamesOfClass(_ theClass: Any) -> [String] {
        return Mirror(reflecting: theClass).children.filter { $0.label != nil }.map { $0.label! }
    }

    open static func colorValue(_ jsonObject: [String: Any], key: String) -> UIColor {
        if let value = jsonObject[key] as? String {
            return value.hexToUIColor
        }else if let array = jsonObject[key] as? [String] {
            return array[0].hexToUIColor
        }else if let object = jsonObject[key] {
            return "\(object)".removeNull().hexToUIColor
        }
        return .white
    }
}

extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }

    func removeNull() -> String{
        if self == "<null>"{
            return ""
        }
        return self
    }

    var trimmed: String{
        return self.replacingOccurrences(of: " ", with: "")
    }
}
