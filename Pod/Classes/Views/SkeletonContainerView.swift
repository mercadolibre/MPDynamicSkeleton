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
        
        self.translatesAutoresizingMaskIntoConstraints = false

        if let topOffset = model.top {
            let top = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: parentView, attribute: .top, multiplier: 1, constant: CGFloat(topOffset))
            NSLayoutConstraint.activate([top])
        }
        if let bottomOffset = model.bottom {
            let bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: parentView, attribute: .bottom, multiplier: 1, constant: -CGFloat(bottomOffset))
            NSLayoutConstraint.activate([bottom])
        }
        if let leftOffset = model.left {
            let left = NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: parentView, attribute: .left, multiplier: 1, constant: CGFloat(leftOffset))
            NSLayoutConstraint.activate([left])
        }
        if let rightOffset = model.right {
            let right = NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: parentView, attribute: .right, multiplier: 1, constant: CGFloat(rightOffset))
            NSLayoutConstraint.activate([right])
        }

        parentView.layoutSubviews()
    }
    
    func setContainerheight(model: DynamicSkeletonModel) {
        if let offsetHeight = model.height {
            let hegiht = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(offsetHeight))
            NSLayoutConstraint.activate([hegiht])
            self.layoutSubviews()
        }
    }
}
