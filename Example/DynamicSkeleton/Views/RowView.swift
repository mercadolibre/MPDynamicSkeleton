//
//  RowView.swift
//  DynamicSkeleton
//
//  Created by Marcelo Oscar José on 8/8/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class RowView: UIView {

    @IBOutlet weak var activityImage: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupElements()
    }

    func setupElements() {
        activityImage.layer.cornerRadius = 25
    }
}
