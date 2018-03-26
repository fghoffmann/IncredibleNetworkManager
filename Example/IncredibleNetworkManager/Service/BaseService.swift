//
//  BaseService.swift
//  IncredibleNetworkManager_Example
//
//  Created by Fabio Gustavo Hoffmann on 25/03/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import IncredibleNetworkManager

protocol BaseService {

}

extension BaseService {
    static func performRequest(_ urlString: String?,
                               method: URLMethod? = .GET,
                               bodyData: Data? = nil,
                               headerValues: [[String]]? = nil,
                               shouldCache: Bool = false,
                               completion:@escaping (_ data: Data?) -> Void,
                               timeoutAfter timeout: TimeInterval = 120,
                               onTimeout: (()->Void)? = nil) -> URLSessionDataTask? {
        return NetworkManager.shared?.performRequest(urlString,
                                         method: method,
                                         bodyData: bodyData,
                                         headerValues: headerValues,
                                         shouldCache: shouldCache,
                                         completion: { data in
                                            completion(data)
        }, timeoutAfter: timeout) {

        }
    }
}
