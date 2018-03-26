//
//  ImageListViewController.swift
//  IncredibleNetworkManager_Example
//
//  Created by Fabio Gustavo Hoffmann on 25/03/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class ImageListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let viewModel = ImageListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)

        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: collectionView.bounds.width, height: 160)

        viewModel.getData(collectionView: collectionView)

        // Do any additional setup after loading the view.
    }
}

extension ImageListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        viewModel.scrollViewDidScroll(scrollView, collectionView: collectionView)
    }
}
