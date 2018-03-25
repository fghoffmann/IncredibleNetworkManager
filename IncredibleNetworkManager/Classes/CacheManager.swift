//
//  CacheManager.swift
//  Pods
//
//  Created by Fabio Gustavo Hoffmann on 24/03/18.
//

import UIKit

class CacheManager: NSObject {

    /*
     *   Sets the cache size for the application
     *   @param memorySize: Size of cache in memory
     *   @param diskSize: Size of cache in disk
     */
    open static func configureCache(withMemorySize memorySize: Int = 15, diskSize: Int = 200){
        let cacheSizeMemory = memorySize*1024*1024
        let cacheSizeDisk = diskSize*1024*1024
        let cache = URLCache(memoryCapacity: cacheSizeMemory, diskCapacity: cacheSizeDisk, diskPath: nil)
        URLCache.shared = cache
    }

    /*
     *   Clears cache
     */
    open static func clearCache(){
        URLCache.shared.removeAllCachedResponses()
    }

    /*
     *   Get cached object for urlRequest
     *   @param urlRequest: Request for cached data
     */
    open static func getCachedObject(_ urlRequest: URLRequest) -> Data?{
        if let cachedObject = URLCache.shared.cachedResponse(for: urlRequest) {
            return cachedObject.data
        }
        return nil
    }

    /*
     *   Set object to cache
     *   @param data: data to cache
     */
    open static func cacheObject(_ urlRequest: URLRequest?, response: URLResponse?, data: Data?){
        guard let urlRequest = urlRequest else{
            return
        }

        guard let response = response else{
            return
        }

        guard let data = data else{
            return
        }

        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }

}
