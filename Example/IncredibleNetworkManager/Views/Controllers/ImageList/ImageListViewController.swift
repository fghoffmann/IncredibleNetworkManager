//
//  ImageListViewController.swift
//  IncredibleNetworkManager_Example
//
//  Created by Fabio Gustavo Hoffmann on 25/03/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class ImageListViewController: UIViewController {
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingLabel: UILabel!

    @IBOutlet weak var collectionView: UICollectionView!

    let viewModel = ImageListViewModel()
    let coverFlowCollectionViewLayout = CoverFlowLayout()
    var refresher: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.allowsSelection = false
        collectionView.indicatorStyle = .white
        collectionView.collectionViewLayout = coverFlowCollectionViewLayout
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer))
        self.collectionView.addGestureRecognizer(tapGestureRecognizer)
        self.collectionView.collectionViewLayout.invalidateLayout()

        gradientView.frame = self.view.frame
        gradientView.frame.origin.x = 0
        gradientView.frame.origin.y = 0
        gradientView.startColor = UIColor(red: 55/255, green: 100/255, blue: 142/255, alpha: 0.8)
        gradientView.endColor = UIColor(red: 7/255, green: 12/255, blue: 17/255, alpha: 1)
        //collectionView.backgroundView = gradientView
        self.view.addSubview(gradientView)
        self.view.sendSubview(toBack: gradientView)
        viewModel.getData(viewController: self)
    }

    @objc func handleTapGestureRecognizer(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state != .recognized {
            return
        }

        let point = recognizer.location(in: self.collectionView)
        guard let indexPath = self.collectionView.indexPathForItem(at: point) else {
            return
        }

        let centered = coverFlowCollectionViewLayout.indexPathIsCentered(indexPath)

        if (centered) {
            guard let cell = self.collectionView.cellForItem(at: indexPath) else {
                return
            }

            UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromRight, animations: {
                cell.bounds = cell.bounds
            }, completion: nil)
        } else {
            var proposedOffset = CGPoint(x: 0, y: 0)
            proposedOffset.x = CGFloat(indexPath.item) * (coverFlowCollectionViewLayout.itemSize.width + coverFlowCollectionViewLayout.minimumLineSpacing)

            let contentOffset = coverFlowCollectionViewLayout.targetContentOffset(forProposedContentOffset: proposedOffset, withScrollingVelocity: CGPoint(x: 0, y: 0))

            self.collectionView.setContentOffset(contentOffset, animated: true)
        }
    }
}

extension ImageListViewController: UICollectionViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sectionCount()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemsCount(section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.cell(collectionView, viewController: self, indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.willDisplay(collectionView, cell: cell, indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelect(collectionView, viewController: self, indexPath: indexPath)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let inset = scrollView.contentInset
        let y: CGFloat = offset.x - inset.left
        let reload_distance: CGFloat = -75
        if y < reload_distance {
            viewModel.getData(viewController: self)
        } else if y > collectionView.collectionViewLayout.collectionViewContentSize.width - UIScreen.main.bounds.width {
            viewModel.getMoreData(viewController: self)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let left = 58 * UIScreen.main.bounds.width / 375
        return UIEdgeInsetsMake(0, left, 0, 300)
    }
}
