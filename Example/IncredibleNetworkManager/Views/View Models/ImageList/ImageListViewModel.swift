//
//  ImageListViewModel.swift
//  IncredibleNetworkManager_Example
//
//  Created by Fabio Gustavo Hoffmann on 25/03/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class ImageListViewModel: NSObject {
    var pictures: [PictureModel] = []

    func getData(collectionView: UICollectionView) {
        PictureService.getPictures(success: { pictures in
            self.pictures = pictures
            collectionView.reloadSections([0])
        }) { (message) in
            print(message ?? "")
        }
    }
}

extension ImageListViewModel {
    func sectionCount() -> Int {
        return 1
    }

    func itemsCount(_ section: Int) -> Int {
        return pictures.count
    }

    func cell(_ collectionView: UICollectionView, viewController: UIViewController, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageLoadedCell", for: indexPath) as! ImageLoadedCollectionViewCell
        cell.titleLabel.text = pictures[indexPath.item].user?.name ?? ""
        cell.dateLabel.text = pictures[indexPath.item].createdAt.toString(format: "MM-dd-yyyy hh:mm")
        cell.dateLabel.text = "\(pictures[indexPath.item].likes) likes"
        cell.updateParalaxOffset(collectionViewBounds: collectionView.bounds)
        _ = cell.imageView.setImage(pictures[indexPath.item].urls["thumb"]) { _ in }
        return cell
    }

    func willDisplay(_ collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath) {
        if let cell = cell as? ImageLoadedCollectionViewCell {
            _ = cell.imageView.setImage(pictures[indexPath.item].urls["full"]) { _ in }
        }
    }

    func didSelect(_ collectionView: UICollectionView, viewController: UIViewController, indexPath: IndexPath) {

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView, collectionView: UICollectionView) {
        let cells = collectionView.visibleCells as! [ImageLoadedCollectionViewCell]
        let bounds = collectionView.bounds
        for cell in cells {
            cell.updateParalaxOffset(collectionViewBounds: bounds)
        }
        
    }
}
