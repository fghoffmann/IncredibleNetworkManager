//
//  String+DataConverter.swift
//  Pods
//
//  Created by Fabio Gustavo Hoffmann on 24/03/18.
//

import UIKit

extension String {
    public var utf8Data: Data? {
        return data(using: String.Encoding.utf8)
    }

    public var stripHTML: String? {
        return replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }

    public var hexToUIColor: UIColor {
        get {
            var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

            if (cString.hasPrefix("#")) {
                cString.remove(at: cString.startIndex)
            }

            if ((cString.count) != 6) {
                return UIColor.gray
            }

            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)

            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
    }
}
