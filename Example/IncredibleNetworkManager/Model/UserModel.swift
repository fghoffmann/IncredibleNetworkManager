//
//  UserModel.swift
//  IncredibleNetworkManager_Example
//
//  Created by Fabio Gustavo Hoffmann on 25/03/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class UserModel: BaseModel {
    let id: String
    let username: String
    let name: String
    let profileImage: [String: String]
    let links: [String: String]

    required init(dictionary: JSON) {
        id = dictionary.parseString(key: "id")
        username = dictionary.parseString(key: "username")
        name = dictionary.parseString(key: "name")

        if let profileImageDictionary = dictionary["profile_image"] as? [String: String] {
            profileImage = profileImageDictionary
        } else {
            profileImage = [:]
        }

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
