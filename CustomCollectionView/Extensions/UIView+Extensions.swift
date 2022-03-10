//
//  UIView+Extensions.swift
//  CustomCollectionView
//
//  Created by Matheus Gois on 10/03/22.
//  Copyright © 2022 4A5. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func constraintToSuperview(constant: CGFloat = .zero) {
        if let view = self.superview {
            self
                .topAnchor(equalTo: view.topAnchor, constant: constant)
                .leadingAnchor(equalTo: view.leadingAnchor, constant: constant)
                .trailingAnchor(equalTo: view.trailingAnchor, constant: -constant)
                .bottomAnchor(equalTo: view.bottomAnchor, constant: -constant)
        }
    }

    @discardableResult func constraintTo(_ layout: UILayoutGuide, constant: CGFloat = .zero) -> Self {
        self
            .topAnchor(equalTo: layout.topAnchor, constant: constant)
            .leadingAnchor(equalTo: layout.leadingAnchor, constant: constant)
            .trailingAnchor(equalTo: layout.trailingAnchor, constant: -constant)
            .bottomAnchor(equalTo: layout.bottomAnchor, constant: -constant)
        return self
    }

    @discardableResult func topAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = topAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func bottomAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = bottomAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func leadingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = leadingAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func trailingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = trailingAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult func heightAnchor(equalTo nsLayoutDimension: NSLayoutDimension, multiplier: CGFloat = 1.0, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let heightConstraint = heightAnchor.constraint(equalTo: nsLayoutDimension, multiplier: multiplier)
        heightConstraint.priority = priority
        heightConstraint.isActive = true
        return self
    }

    @discardableResult func widthAnchor(equalTo width: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        let constraint = widthAnchor.constraint(equalToConstant: width)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    func findConstraint(attribute layoutAttribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        switch layoutAttribute {
        case .height, .width:
            for constraint in constraints where itemMatch(constraint: constraint, layoutAttribute: layoutAttribute) {
                return constraint
            }
            return nil
        default:
            if let constraints = superview?.constraints {
                for constraint in constraints where itemMatch(constraint: constraint, layoutAttribute: layoutAttribute) {
                    return constraint
                }
            }
            return nil
        }
    }

    func findConstraint(identifier: String) -> NSLayoutConstraint? {
        return superview?.constraints.first { $0.identifier == identifier }
    }

    func itemMatch(constraint: NSLayoutConstraint, layoutAttribute: NSLayoutConstraint.Attribute) -> Bool {
        switch layoutAttribute {
        case .height, .width:
            if let firstItem = constraint.firstItem as? UIView {
                return firstItem == self && constraint.firstAttribute == layoutAttribute
            }
            return false
        default:
            if let firstItem = constraint.firstItem as? UIView, let secondItem = constraint.secondItem as? UIView {
                let firstItemMatch = firstItem == self && constraint.firstAttribute == layoutAttribute
                let secondItemMatch = secondItem == self && constraint.secondAttribute == layoutAttribute
                return firstItemMatch || secondItemMatch
            }
            return false
        }
    }
}
