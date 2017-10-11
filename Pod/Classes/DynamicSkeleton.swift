//
//  DynamicSkeleton.swift
//  Pods
//
//  Created by Marcelo Oscar José on 7/29/17.
//
//

import UIKit

@objc public class DynamicSkeletonModel: NSObject {
    
    var view: UINib = UINib()
    var repeating: Int = 1
    
    var left: Int?
    var right: Int?
    var top: Int?
    var bottom: Int?
    var height: Int?
    
    override init() {
        
    }
    
    public convenience init(view: UINib, repeating: Int, left: Int, right: Int, top: Int, bottom: Int, height: Int) {
        self.init()
        self.view = view
        self.repeating = repeating
        
        self.left = left
        self.right = right
        self.top = top
        self.bottom = bottom
        self.height = height
    }
    
    public convenience init(view: UINib, repeating: Int, left: Int, right: Int, top: Int, height: Int) {
        self.init()
        self.view = view
        self.repeating = repeating
        
        self.left = left
        self.right = right
        self.top = top
        self.height = height
    }
    
    public convenience init(view: UINib, repeating: Int, left: Int, right: Int, bottom: Int, height: Int) {
        self.init()
        self.view = view
        self.repeating = repeating
        
        self.left = left
        self.right = right
        self.bottom = bottom
        self.height = height
    }
}

public class DynamicSkeleton: NSObject {
    
    public static let sharedInstance = DynamicSkeleton()
    var mainView: UIView!
    var skeletonMainView: SkeletonMainView!
    
    public func presentSkeleton(view: UIView, models: [DynamicSkeletonModel]) {
        
        if let skeletonView = self.skeletonMainView {
            view.addSubview(skeletonView)
        } else {
            skeletonMainView = SkeletonMainView(parentView: view)
            self.createSkeleton(models: models)
        }
    }
    
    public func dismissSkeleton(completion: @escaping () -> Void) {

        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut, animations: {
            if self.skeletonMainView != nil {
                self.skeletonMainView.alpha = 0
            }
        }) { _ in
            if self.skeletonMainView != nil {
                self.skeletonMainView.removeFromSuperview()
                self.skeletonMainView = nil
            }
            completion()
        }
    }
    
    func createSkeleton(models: [DynamicSkeletonModel]) {
        
        for model in models {
            
            let containerView = SkeletonContainerView(model: model, parentView: skeletonMainView)
            
            if model.repeating != 0 {
                containerView.setContainerheight(model: model)
            }
            
            let repeating = (model.repeating == 0 ? Int(ceil(containerView.frame.height / CGFloat(model.height!))) + 1 : model.repeating)
            
            for index in 1...repeating {
                createSkeletonViews(model: model, containerView: containerView, index: (index - 1))
            }
        }
    }
    
    func createSkeletonViews(model: DynamicSkeletonModel, containerView: UIView, index: Int) {
        
        let view = model.view.instantiate(withOwner: nil, options: nil).first as! UIView
        let topOffset = CGFloat(model.height! * index)

        view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(view)

        let top = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: CGFloat(topOffset))
        let left = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: containerView, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: containerView, attribute: .right, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([top, left, right])

        if let offsetHeight = model.height {
            let hegiht = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(offsetHeight))
            NSLayoutConstraint.activate([hegiht])
        }
        
        for element in view.subviews {
            if let elementSkeleton = element as? SkeletonElementView {
                elementSkeleton.setGradientColor()
                elementSkeleton.slide(direction: .right)
            }
        }
    }
}
