//
//  UIView.swift
//  Pods
//
//  Created by Marcelo Oscar José on 8/1/17.
//
//

import UIKit

extension UIView {

    func fadeOut(_ duration: TimeInterval = 10.0, delay: TimeInterval = 10.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}
