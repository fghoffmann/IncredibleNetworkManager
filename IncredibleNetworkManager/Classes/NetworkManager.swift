//
//  NetworkManager.swift
//  Pods
//
//  Created by Fabio Gustavo Hoffmann on 24/03/18.
//

import Foundation

public class NetworkManager: NSObject {
    // MARK: - Properties
    public static var shared: NetworkManager?

    // MARK: - Static Methods
    public static func initializeNetworkManager() {
        shared = NetworkManager()
    }

    // MARK: - Class Methods

    /*
     *   Fetch data from URL with NSUrlSession
     *   @param urlString: Url to fetch data form
     *   @param method: URL method to fetch data using URLMethod enum
     *   @param headerValues: Any header values to complete the request
     *   @param shouldCache: Cache fetched data, if on, it will check first for data in cache, then fetch if not found
     *   @param completion: Returns fetched NSData in a block
     */
    public func performRequest(_ urlString: String?,
                               method: URLMethod? = .GET,
                               bodyData: Data? = nil,
                               headerValues: [[String]]? = nil,
                               shouldCache: Bool = false,
                               completion:@escaping (_ data: Data?) -> Void,
                               timeoutAfter timeout: TimeInterval = 120,
                                onTimeout: (()->Void)? = nil) -> URLSessionDataTask? {
        return  Requester.performRequest(urlString,
                                         method: method,
                                         bodyData: bodyData,
                                         headerValues: headerValues,
                                         shouldCache: shouldCache,
                                         completion: { data in
            completion(data)
        }, timeoutAfter: timeout) {
            onTimeout!()
        }
    }
}
