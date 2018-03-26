//
//  ImageLoadedCollectionViewCell.swift
//  IncredibleNetworkManager_Example
//
//  Created by Fabio Gustavo Hoffmann on 25/03/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class ImageLoadedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewCenterYLayoutContraint: NSLayoutConstraint!

    var layoutChangeSegmentedControl: UISegmentedControl?
    var coverFlowCollectionViewLayout: CoverFlowLayout?

    var parallaxOffset: CGFloat = 0 {
        didSet {
            imageViewCenterYLayoutContraint.constant = parallaxOffset
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = false
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        mask?.alpha = 0.0
        self.layer.shouldRasterize = false

        self.layer.shouldRasterize = layoutAttributes.shouldRasterize
        mask?.alpha = layoutAttributes.maskingValue
    }

    func updateParalaxOffset(collectionViewBounds bounds: CGRect) {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let offsetFromCenter = CGPoint(x: center.x - self.center.x, y: center.y - self.center.y)
        let maxVerticalOffset = (bounds.height / 2) + (self.bounds.height / 2)
        let scaleFactor = 40 / maxVerticalOffset
        parallaxOffset = -offsetFromCenter.y * scaleFactor
    }
}
