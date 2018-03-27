//
//  CoverFlowLayout.swift
//  IncredibleNetworkManager_Example
//
//  Created by Hoffmann, Fabio Gustavo on 26/03/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

let ACTIVE_DISTANCE: CGFloat = 100
let TRANSLATE_DISTANCE: CGFloat = 100
let ZOOM_FACTOR: CGFloat = 0.2
let FLOW_OFFSET: CGFloat = 40
let INACTIVE_GREY_VALUE: CGFloat = 0.6

class CoverFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()

        // Set up our basic properties
        self.scrollDirection = .horizontal
        let size = 220 * UIScreen.main.bounds.width / 320
        self.itemSize = CGSize(width: size, height: size)
        self.minimumLineSpacing = -60      // Gets items up close to one another
        self.minimumInteritemSpacing = 1000 // Makes sure we only have 1 row of items in portrait mode
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributesArray = super.layoutAttributesForElements(in: rect)

        let visibleRect = CGRect(x: self.collectionView?.contentOffset.x ?? 0.0,
                                 y: self.collectionView?.contentOffset.y ?? 0.0,
                                 width: self.collectionView?.bounds.width ?? 0.0,
                                 height: self.collectionView?.bounds.height ?? 0.0)

        for attributes in layoutAttributesArray ?? [] {
            if attributes.frame.intersects(rect) {
                self.applyLayoutAttributes(attributes, forVisibleRect: visibleRect)
            }
        }

        return layoutAttributesArray
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if let attributes = super.layoutAttributesForItem(at: indexPath) {

            let visibleRect = CGRect(x: self.collectionView?.contentOffset.x ?? 0.0,
                                     y: self.collectionView?.contentOffset.y ?? 0.0,
                                     width: self.collectionView?.bounds.width ?? 0.0,
                                     height: self.collectionView?.bounds.height ?? 0.0)

            self.applyLayoutAttributes(attributes, forVisibleRect: visibleRect)
            return attributes
        }
        return nil
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        // Returns a point where we want the collection view to stop scrolling at.
        // First, calculate the proposed center of the collection view once the collection view has stopped
        var offsetAdjustment = MAXFLOAT;
        let horizontalCenter = proposedContentOffset.x +
            ((self.collectionView?.bounds.width ?? 0) / 2.0)
        // Use the center to find the proposed visible rect.
        let proposedRect = CGRect(x: proposedContentOffset.x, y: 0.0,
                                  width: self.collectionView?.bounds.size.width ?? 0.0,
                                  height: self.collectionView?.bounds.size.height ?? 0.0)

        // Get the attributes for the cells in that rect.
        let array = self.layoutAttributesForElements(in: proposedRect)

        // This loop will find the closest cell to proposed center of the collection view
        for layoutAttributes in array ?? [] {
            // We want to skip supplementary views
            if layoutAttributes.representedElementCategory != UICollectionElementCategory.cell {
                continue
            }

            // Determine if this layout attribute's cell is closer than the closest we have so far
            let itemHorizontalCenter = layoutAttributes.center.x
            if (fabsf(Float(itemHorizontalCenter - horizontalCenter)) < fabsf(offsetAdjustment)) {
                offsetAdjustment = Float(itemHorizontalCenter - horizontalCenter)
            }
        }

        return CGPoint(x: proposedContentOffset.x + CGFloat(offsetAdjustment),
                       y: proposedContentOffset.y)
    }

    func applyLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes,
                               forVisibleRect visibleRect: CGRect) {
        // Applies the cover flow effect to the given layout attributes.

        // We want to skip supplementary views.
        if attributes.representedElementKind != nil {
            return
        }

        // Calculate the distance from the center of the visible rect to the center of the attributes.
        // Then normalize it so we can compare them all. This way, all items further away than the
        // active get the same transform.
        let distanceFromVisibleRectToItem = visibleRect.midX - attributes.center.x
        let normalizedDistance = distanceFromVisibleRectToItem / ACTIVE_DISTANCE
        let isLeft = distanceFromVisibleRectToItem > 0
        var transform = CATransform3DIdentity

        var maskAlpha: CGFloat = 0.0

        if (CGFloat(fabsf(Float(distanceFromVisibleRectToItem))) < ACTIVE_DISTANCE)
        {
            // We're close enough to apply the transform in relation to
            // how far away from the center we are.
            transform = CATransform3DTranslate(
                CATransform3DIdentity,
                (isLeft ? -FLOW_OFFSET : FLOW_OFFSET) *
                    abs(distanceFromVisibleRectToItem / TRANSLATE_DISTANCE),
                0, (1 - CGFloat(fabsf(Float(normalizedDistance)))) * 40000 + (isLeft ? 240 : 0))

            transform = CATransform3DTranslate(
                CATransform3DIdentity,
                (isLeft ? -FLOW_OFFSET : FLOW_OFFSET) *
                    abs(distanceFromVisibleRectToItem / TRANSLATE_DISTANCE),
                0, (1 - CGFloat(fabsf(Float(normalizedDistance)))) * 40000 + (isLeft ? 240 : 0))

            // Set the perspective of the transform.
            transform.m34 = -1/(4.6777 * self.itemSize.width)

            // Set the zoom factor.
            let zoom = 1 + ZOOM_FACTOR * (1 - abs(normalizedDistance));
            transform = CATransform3DRotate(
                transform, (isLeft ? 1 : -1) * CGFloat(fabsf(Float(normalizedDistance))) *
                    45 * CGFloat(Double.pi) / 180, 0, 1, 0)
            transform = CATransform3DScale(transform, zoom, zoom, 1)
            attributes.zIndex = 1

            let ratioToCenter = (ACTIVE_DISTANCE - CGFloat(fabsf(Float(distanceFromVisibleRectToItem)))) / ACTIVE_DISTANCE
            // Interpolate between 0.0f and INACTIVE_GREY_VALUE
            maskAlpha = INACTIVE_GREY_VALUE + ratioToCenter * (-INACTIVE_GREY_VALUE)
        }
        else
        {
            // We're too far away - just apply a standard perspective transform.
            transform.m34 = -1/(4.6777 * self.itemSize.width)
            transform = CATransform3DTranslate(transform, isLeft ? -FLOW_OFFSET : FLOW_OFFSET, 0, 0)
            transform = CATransform3DRotate(transform, (isLeft ? 1 : -1) *
                45 * CGFloat(Double.pi) / 180, 0, 1, 0)
            attributes.zIndex = 0

            maskAlpha = INACTIVE_GREY_VALUE;
        }

        attributes.transform3D = transform;

        // Rasterize the cells for smoother edges.
        attributes.shouldRasterize = true
        attributes.maskingValue = 0
    }

    func indexPathIsCentered(_ indexPath: IndexPath) -> Bool {
        let visibleRect = CGRect(x: self.collectionView?.contentOffset.x ?? 0.0,
                                 y: self.collectionView?.contentOffset.y ?? 0.0,
                                 width: self.collectionView?.bounds.width ?? 0.0,
                                 height: self.collectionView?.bounds.height ?? 0.0)

        if let attributes = self.layoutAttributesForItem(at: indexPath) {
            let distanceFromVisibleRectToItem = visibleRect.midX - attributes.center.x;
            return fabs(distanceFromVisibleRectToItem) < 1
        }

        return false
    }

}
