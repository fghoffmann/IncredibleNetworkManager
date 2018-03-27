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
}
