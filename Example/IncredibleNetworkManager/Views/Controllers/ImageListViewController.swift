//
//  ImageListViewController.swift
//  IncredibleNetworkManager_Example
//
//  Created by Fabio Gustavo Hoffmann on 25/03/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class ImageListViewController: UIViewController {

    var viewModel: ImageListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ImageListViewModel()

        // Do any additional setup after loading the view.
    }

}
