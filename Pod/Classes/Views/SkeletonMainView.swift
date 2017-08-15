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

        self.translatesAutoresizingMaskIntoConstraints = false

        let top = self.topAnchor.constraint(equalTo: parentView.topAnchor)
        let bottom = self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        let leading = self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor)
        let trailing = self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        NSLayoutConstraint.activate([top, bottom, leading, trailing])
    }
}
