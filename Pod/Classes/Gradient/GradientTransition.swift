//
//  GradientTransition.swift
//  Pods
//
//  Created by Marcelo Oscar José on 7/29/17.
//
//

import Foundation

/// A `Transition` between two `GradientPoint`s.
typealias GradientTransition = Transition<GradientPoint>

/// A generic structure to represent a transition.
struct Transition<T> {
    /// The beginning of the Transition.
    let from: T
    /// The end of the Transition.
    let to: T
}

infix operator -->: AdditionPrecedence
/// A custom operator that builds a `Transition<T>`
func --><T>(from: T, to: T) -> Transition<T> {
    return Transition.init(from: from, to: to)
}
