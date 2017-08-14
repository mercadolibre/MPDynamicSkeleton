//
//  SkeletonContainerView.swift
//  Pods
//
//  Created by Marcelo Oscar José on 8/4/17.
//
//

import UIKit

class SkeletonContainerView: UIView {
    
    convenience init(model: DynamicSkeletonModel, parentView: UIView) {
        self.init(frame: .zero)
        parentView.addSubview(self)
        self.setupElements()
        self.setupConstraints(model: model, parentView: parentView)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupElements() {
        self.clipsToBounds = true
    }
    
    func setupConstraints(model: DynamicSkeletonModel, parentView: UIView) {
        if let topOffset = model.top {
            self.autoPinEdge(.top, to: .top, of: parentView, withOffset: CGFloat(topOffset))
        }
        if let bottomOffset = model.bottom {
            self.autoPinEdge(.bottom, to: .bottom, of: parentView, withOffset: CGFloat(-bottomOffset))
        }
        if let leftOffset = model.left {
            self.autoPinEdge(.left, to: .left, of: parentView, withOffset: CGFloat(leftOffset))
        }
        if let rightOffset = model.right {
            self.autoPinEdge(.right, to: .right, of: parentView, withOffset: CGFloat(-rightOffset))
        }
        
        parentView.layoutSubviews()
    }
    
    func setContainerheight(model: DynamicSkeletonModel) {
        if let offsetHeight = model.height {
            self.autoSetDimension(.height, toSize: CGFloat(offsetHeight))
            self.layoutSubviews()
        }
    }
}
