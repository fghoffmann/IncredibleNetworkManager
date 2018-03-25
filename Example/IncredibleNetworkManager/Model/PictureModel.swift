//
//  UserModel.swift
//  IncredibleNetworkManager_Example
//
//  Created by Fabio Gustavo Hoffmann on 25/03/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class PictureModel: BaseModel {
    let id: String
    let createdAt: Date
    let width: Int
    let height: Int
    let color: UIColor
    let likes: Int
    let likedByUser: Bool
    let user: UserModel?
    let currentUserCollections: [CollectionModel]
    let urls: [String: String]
    let categories: [CategoryModel]
    let links: [String: String]

    func toDictionary() -> JSON {
        return [:]
    }

    required init(dictionary: JSON) {
        id = dictionary.parseString(key: "id")
        createdAt = dictionary.parseDate(key: "created_at") ?? Date()
        width = dictionary.parseInt(key: "width")
        height = dictionary.parseInt(key: "height")
        color = dictionary.parseColor(key: "color")
        likes = dictionary.parseInt(key: "likes")
        likedByUser = dictionary.parseBool(key: "liked_by_user")
        categories = CategoryModel.models(from: dictionary["categories"])
        user = UserModel.model(from: dictionary["user"])

        currentUserCollections = []

        if let urlsDictionary = dictionary["urls"] as? [String: String] {
            self.urls = urlsDictionary
        } else {
            self.urls = [:]
        }

        if let linksDictionary = dictionary["links"] as? [String: String] {
            links = linksDictionary
        } else {
            links = [:]
        }
    }
}
