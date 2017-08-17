//
//  GradientView.swift
//  Pods
//
//  Created by Marcelo Oscar José on 7/29/17.
//
//

import UIKit

/// A view who's `layerClass` is a `CAGradientLayer`.
public class GradientView: UIView {
    override open class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}

extension GradientView {
    /// A convenient way to access the `GradientView`'s corresponding `CAGradientLayer`.
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    /// A convenient way to slide the `GradientView`'s corresponding `CAGradientLayer`.
    func slide(direction: GradientDirection) {
        return gradientLayer.slide(direction: direction)
    }
    
    /// A convenient way to stop sliding the `GradientView`'s corresponding `CAGradientLayer`.
    func stopSliding() {
        return gradientLayer.stopSliding()
    }
}
