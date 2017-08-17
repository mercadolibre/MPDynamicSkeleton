//
//  GradientDirection.swift
//  Pods
//
//  Created by Marcelo Oscar José on 7/29/17.
//
//

import Foundation

enum GradientProperty {
    case startPoint
    case endPoint
}

public enum GradientDirection {
    case right
    case left

    func transition(for point: GradientProperty) -> GradientTransition {
        switch (self, point) {
        case (.right, .startPoint):
            return GradientPoint(x: .negativeOne) --> GradientPoint(x: .one)
        case (.right, .endPoint):
            return GradientPoint(x: .zero) --> GradientPoint(x: .two)
        case (.left, .startPoint):
            return GradientPoint(x: .one) --> GradientPoint(x: .negativeOne)
        case (.left, .endPoint):
            return GradientPoint(x: .two) --> GradientPoint(x: .zero)
        }
    }
}
