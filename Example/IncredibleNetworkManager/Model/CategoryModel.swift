//
//  CategoryModel.swift
//  IncredibleNetworkManager_Example
//
//  Created by Fabio Gustavo Hoffmann on 25/03/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class CategoryModel: BaseModel {
    let id: String
    let title: String
    let photoCount: Int
    let links: [String: String]

    required init(dictionary: JSON) {
        id = dictionary.parseString(key: "id")
        title = dictionary.parseString(key: "title")
        photoCount = dictionary.parseInt(key: "photo_count")

        if let linksDictionary = dictionary["links"] as? [String: String] {
            links = linksDictionary
        } else {
            links = [:]
        }
    }

    func toDictionary() -> JSON {
        return [:]
    }

}
