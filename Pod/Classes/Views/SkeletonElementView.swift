//
//  SkeletonView.swift
//  Pods
//
//  Created by Marcelo Oscar José on 7/29/17.
//
//

import UIKit

public class SkeletonElementView: UIView {

    private let brightened: CGFloat = 0.94
    public let gradientView = GradientView(frame: .zero)

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setUpGradientView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpGradientView()
    }

    fileprivate func setUpGradientView() {
        gradientView.backgroundColor = UIColor.clear
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gradientView)

        let top = gradientView.topAnchor.constraint(equalTo: topAnchor)
        let bottom = gradientView.bottomAnchor.constraint(equalTo: bottomAnchor)
        let leading = gradientView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailing = gradientView.trailingAnchor.constraint(equalTo: trailingAnchor)
        NSLayoutConstraint.activate([top, bottom, leading, trailing])
    }

    public func setGradientColor() {
        gradientView.layer.cornerRadius = self.layer.cornerRadius
        gradientView.layer.borderWidth = self.layer.borderWidth
        if let color = self.backgroundColor {
            self.gradientView.gradientLayer.colors = [color.cgColor, color.brightened(by: brightened).cgColor, color.cgColor]
        }
    }

    public func slide(direction: GradientDirection) {
        self.gradientView.gradientLayer.slide(direction: direction)
    }

    public func stopSliding() {
        self.gradientView.gradientLayer.stopSliding()
    }
}
