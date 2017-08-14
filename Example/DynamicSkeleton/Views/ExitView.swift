//
//  ExitView.swift
//  DynamicSkeleton
//
//  Created by Marcelo Oscar José on 7/31/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import DynamicSkeleton
import PureLayout

class ExitView: UIView {

    @IBOutlet weak var dismissButton: UIButton!

    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBAction func dismissSkeleton(_ sender: Any) {
        DynamicSkeleton.sharedInstance.dismissSkeleton {
            print("Execute action after dismiss")
        }
    }
}
