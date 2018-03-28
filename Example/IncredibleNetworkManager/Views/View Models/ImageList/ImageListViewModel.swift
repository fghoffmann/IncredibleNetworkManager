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
    var canUpdateAgain = true

    func getData(viewController: UIViewController) {
        if canUpdateAgain {
            canUpdateAgain = false
            if let viewController = viewController as? ImageListViewController {
                let customLoading = CustomLoading(size: 32, color: .white)
                viewController.loadingView.addSubview(customLoading)
                customLoading.startAnimating()
                viewController.loadingLabel.text = "Refreshing data..."
                PictureService.getPictures(success: { pictures in
                    customLoading.removeFromSuperview()
                    viewController.loadingLabel.text = "Data loaded!"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        UIView.animate(withDuration: 1, animations: {
                            viewController.loadingLabel.text = pictures.count > 0 ? "" : "No more data available"
                        }, completion: { _ in
                            self.canUpdateAgain = true
                        })
                    })
                    self.pictures = pictures
                    viewController.collectionView.reloadSections([0])
                }) { (message) in
                    customLoading.removeFromSuperview()
                    viewController.loadingLabel.text = message
                    print(message ?? "")
                }
            }
        }
    }

    func getMoreData(viewController: UIViewController) {
        if canUpdateAgain {
            canUpdateAgain = false
            if let viewController = viewController as? ImageListViewController {
                let customLoading = CustomLoading(size: 32, color: .white)
                viewController.loadingView.addSubview(customLoading)
                customLoading.startAnimating()
                viewController.loadingLabel.text = "Loading more data..."
                PictureService.getPictures(success: { pictures in
                    customLoading.removeFromSuperview()
                    viewController.loadingLabel.text = "Data loaded!"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        UIView.animate(withDuration: 1, animations: {
                            viewController.loadingLabel.text = pictures.count > 0 ? "" : "No more data available"
                        }, completion: { _ in
                            self.canUpdateAgain = true
                        })
                    })
                    self.pictures.append(contentsOf: pictures)
                    viewController.collectionView.reloadSections([0])
                }) { (message) in
                    customLoading.removeFromSuperview()
                    viewController.loadingLabel.text = message
                    print(message ?? "")
                }
            }
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
        cell.likesLabel.text = "\(pictures[indexPath.item].likes) likes"
        return cell
    }

    func willDisplay(_ collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath) {
        if let cell = cell as? ImageLoadedCollectionViewCell {
            let customLoading = CustomLoading(size: 26, color: .white)
            customLoading.center = cell.imageView.center
            cell.imageView.addSubview(customLoading)
            customLoading.startAnimating()
            _ = cell.imageView.setImage(pictures[indexPath.item].urls["full"],
                thumbnailUrl: pictures[indexPath.item].urls["thumb"], animated: false,
                completion: { _ in
                customLoading.removeFromSuperview()
                if cell.imageView.image == nil {
                    cell.imageView.image = UIImage(named: "placeholder")
                }
            })
        }
    }

    func didSelect(_ collectionView: UICollectionView, viewController: UIViewController, indexPath: IndexPath) {

    }
}
