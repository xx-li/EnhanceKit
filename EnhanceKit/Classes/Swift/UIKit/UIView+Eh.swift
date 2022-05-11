//
//  UIView+Eh.swift
//  EnhanceKit
//
//  Created by Stellar on 2022/3/1.
//

import Foundation

public extension EnhanceWrapper where Base: UIView {
    
    /// 在当前视图所在视图树，找到离此视图最近的父视图（符合传入类型即可）
    /// - Parameters:
    ///   - type: 目标视图类型
    /// - Returns: 找到的目标父视图，找不到返回nil
    func parentView<T: UIView>(of type: T.Type) -> T? {
        guard let view = base.superview else {
            return nil
        }
        return (view as? T) ?? self.parentView(of: T.self)
    }
    
    /// 给视图绘制圆角并避免离屏渲染。支持只对部分位置设置圆角。
    ///
    /// 注意：bounds变更后需要重新调用
    /// - Parameters:
    ///   - corners: 圆角枚举类型
    ///   - radii: 圆角值
    func setRoundCorners(corners: UIRectCorner, with radii: CGFloat) {
        let bezierpath:UIBezierPath = UIBezierPath.init(
            roundedRect: (base.bounds),
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radii, height: radii))
        let shape:CAShapeLayer = CAShapeLayer.init()
        shape.path = bezierpath.cgPath
        base.layer.mask = shape
    }
    
    /// 通过path设置圆角（不会导致离屏渲染）
    /// - Parameter radius: 圆角值
    func setCornerRadius(_ radius: CGFloat) {
        setRoundCorners(corners: .allCorners, with: radius)
    }
    
}
