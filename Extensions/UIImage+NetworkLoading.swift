//
//  UIImage+NetworkLoading.swift
//  Pods
//
//  Created by Fabio Gustavo Hoffmann on 24/03/18.
//

import UIKit

extension UIImage{

    public static func loadImage(_ url: String?, completion:@escaping (_ image: UIImage?) -> Void) -> URLSessionDataTask?{
        if let url = url {
            let task = Requester.performRequest(url, shouldCache: true, completion: { (data) in
                if let data = data {
                    completion(UIImage(data: data))
                }else{
                    completion(nil)
                }
            })
            return task
        }
        return nil
    }

}
