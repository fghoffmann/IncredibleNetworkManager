//
//  BaseModel.swift
//  IncredibleNetworkManager_Example
//
//  Created by Fabio Gustavo Hoffmann on 25/03/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import IncredibleNetworkManager

typealias JSON = [String: Any]

protocol BaseModel {
    init(dictionary: JSON)
    func toDictionary() -> JSON
}

extension BaseModel {
    static func dictionary(from models: [Self]) -> [JSON] {
        var array = [JSON]()
        for model in models {
            array.append(model.toDictionary())
        }
        return array
    }

    static func models(from jsonArray: Any?) -> [Self] {
        var models = [Self]()
        if let array = jsonArray as? [Any] {
            for any in array {
                if let dictionary = any as? JSON {
                    let model = Self(dictionary: dictionary)
                    models.append(model)
                }
            }
        }
        return models
    }

    static func model(from json: Any?) -> Self? {
        if let json = json as? JSON {
            return Self(dictionary: json)
        }
        return nil
    }
}
