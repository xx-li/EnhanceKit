//
//  String+Eh.swift
//  EnhanceKit
//
//  Created by lixinxing on 2021/12/29.
//  Copyright © 2021 lixinxing. All rights reserved.

import Foundation

public extension EnhanceWrapper where Base == NSLayoutConstraint {
        
    /// `NSLayoutConstraint`的`multiplier`属性默认是只读，通过新创建NSLayoutConstraint对象替换来提供可写功能
    /// - Parameter multiplier: multiplier值
    /// - Returns: 新创建的NSLayoutConstraint对象
    @discardableResult
    func setMultiplier(multiplier: CGFloat) -> NSLayoutConstraint {
        guard let firstItem = base.firstItem else {
            return base
        }
        NSLayoutConstraint.deactivate([base])
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: base.firstAttribute,
            relatedBy: base.relation,
            toItem: base.secondItem,
            attribute: base.secondAttribute,
            multiplier: multiplier,
            constant: base.constant)
        newConstraint.priority = base.priority
        newConstraint.shouldBeArchived = base.shouldBeArchived
        newConstraint.identifier = base.identifier
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
