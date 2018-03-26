//
//  PictureService.swift
//  IncredibleNetworkManager_Example
//
//  Created by Fabio Gustavo Hoffmann on 25/03/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class PictureService: BaseService {

    static let kLoadProfilePicturesURL = "http://pastebin.com/raw/wgkJgazE"

    static func getPictures(success:@escaping ([PictureModel])->Void, failure:@escaping (_ message: String?)->Void) {
        _ = performRequest(kLoadProfilePicturesURL, method: .GET, bodyData: nil, completion: { (data) in
            if let jsonObject = data?.parseJSON() as? [JSON] {
                let pictures = PictureModel.models(from: jsonObject)
                success(pictures)
            } else {
                failure("Something went wrong in parsing json object")
            }
        })
    }
}
