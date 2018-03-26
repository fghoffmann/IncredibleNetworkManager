//
//  Data+Parse.swift
//  Pods
//
//  Created by Fabio Gustavo Hoffmann on 25/03/18.
//

import UIKit

extension Data {
    public func parseJSON() -> AnyObject? {
        return Parser.jsonObject(self)
    }
}
