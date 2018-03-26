//
//  CollectionViewLayoutAttributes.swift
//  IncredibleNetworkManager_Example
//
//  Created by Hoffmann, Fabio Gustavo on 26/03/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

var shouldRasterizePointer: Int8 = 0
var maskingValuePointer: Int8 = 0

extension UICollectionViewLayoutAttributes {
    var shouldRasterize: Bool {
        get {
            return objc_getAssociatedObject(self, &shouldRasterizePointer) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &shouldRasterizePointer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        }
    }

    var maskingValue: CGFloat {
        get {
            return objc_getAssociatedObject(self, &maskingValuePointer) as? CGFloat ?? 0.0
        }
        set {
            objc_setAssociatedObject(self, &maskingValuePointer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let attributes = super.copy() as! UICollectionViewLayoutAttributes

        attributes.shouldRasterize = self.shouldRasterize
        attributes.maskingValue = self.maskingValue

        return attributes
    }
}
