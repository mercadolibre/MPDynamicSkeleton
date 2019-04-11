//
//  CAGradientLayer+Slide.swift
//  Pods
//
//  Created by Marcelo Oscar José on 7/29/17.
//
//

import UIKit

extension CABasicAnimation {
    func applyGradientTransition(_ transition: GradientTransition) {
        fromValue = NSValue(cgPoint: transition.from.cgPoint)
        toValue = NSValue(cgPoint: transition.to.cgPoint)
    }
}

public extension CAGradientLayer {

    fileprivate static let KSlideAnimationKey = "SlideAnimation"

    func slide(direction: GradientDirection) {
        let startPointTransition = direction.transition(for: .startPoint)
        let endPointTransition = direction.transition(for: .endPoint)
        
        let startPointAnim = CABasicAnimation(keyPath: #keyPath(startPoint))
        startPointAnim.applyGradientTransition(startPointTransition)
        
        let endPointAnim = CABasicAnimation(keyPath: #keyPath(endPoint))
        endPointAnim.applyGradientTransition(endPointTransition)
        
        let animGroup = CAAnimationGroup()
        animGroup.animations = [startPointAnim, endPointAnim]
        animGroup.duration = 1
        animGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        animGroup.repeatCount = .infinity
        
        add(animGroup, forKey: CAGradientLayer.KSlideAnimationKey)
    }

    func stopSliding() {
        removeAnimation(forKey: CAGradientLayer.KSlideAnimationKey)
    }
}
