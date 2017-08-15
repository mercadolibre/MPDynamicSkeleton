//
//  ViewController.swift
//  DynamicSkeleton
//
//  Created by MarceloJoseML on 07/29/2017.
//  Copyright (c) 2017 MarceloJoseML. All rights reserved.
//

import UIKit
import MPDynamicSkeleton

class ViewController: UIViewController {

    let landingView:UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "landing")
        view.contentMode = .redraw
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.createLandingPage()
        self.createSkeletonContainer()
    }

    func setupNavigationBar() {
        self.title = "DynamicSkeleton"
        self.view.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0 / 255, green: 148 / 255, blue: 223 / 255, alpha: 1)
    }

    func createLandingPage() {
        self.view.addSubview(landingView)
        
        landingView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = landingView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let bottom = landingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let leading = landingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailing = landingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        NSLayoutConstraint.activate([top, bottom, leading, trailing])
    }

    func createSkeletonContainer() {

        let headerView = UINib(nibName: "HeaderView", bundle: Bundle.main)
        let rowView = UINib(nibName: "RowView", bundle: Bundle.main)
        let exitView = UINib(nibName: "ExitView", bundle: Bundle.main)

        let containers = [
            DynamicSkeletonModel(view: headerView, repeating: 1, left: 0, right: 0, top: 0, height: 82),
            DynamicSkeletonModel(view: rowView, repeating: 0, left: 0, right: 0, top: 82, bottom: 50, height: 74),
            DynamicSkeletonModel(view: exitView, repeating: 1, left: 0, right: 0, bottom: 0, height: 50)
        ]

        DynamicSkeleton.sharedInstance.presentSkeleton(view: self.view, models: containers)
    }
}
