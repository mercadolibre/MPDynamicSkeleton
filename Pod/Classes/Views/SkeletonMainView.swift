//
//  SkeletonMainView.swift
//  Pods
//
//  Created by Marcelo Oscar José on 8/4/17.
//
//

import UIKit

class SkeletonMainView: UIView {
    
    convenience init(parentView: UIView) {
        self.init(frame: .zero)
        parentView.addSubview(self)
        self.setupConstraints(parentView: parentView)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupConstraints(parentView: UIView) {
        self.autoPinEdge(.top, to: .top, of: parentView, withOffset: 0)
        self.autoPinEdge(.bottom, to: .bottom, of: parentView, withOffset: 0)
        self.autoPinEdge(.left, to: .left, of: parentView, withOffset: 0)
        self.autoPinEdge(.right, to: .right, of: parentView, withOffset: 0)
        self.layoutSubviews()
    }
}
