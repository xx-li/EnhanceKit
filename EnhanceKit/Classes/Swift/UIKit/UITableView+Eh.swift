//
//  UIView+Eh.swift
//  EnhanceKit
//
//  Created by Stellar on 2022/3/1.
//

import Foundation

/// 用于快捷创建重用视图
public protocol EHReusable: AnyObject {
    /// 重用视图的标识符号
    static var identifier: String { get }
    /// 通过xib创建时，通过此方法获取xib创建信息
    static var nibInfo: (name: String, bundle: Bundle?) { get }
}

extension EHReusable {
    public static var identifier: String {
        return String(reflecting: Self.self)
    }
    
    public static var nibInfo: (name: String, bundle: Bundle?) {
        return (String(describing: Self.self), nil)
    }
}

public extension EnhanceWrapper where Base: UITableView {
    
    /// 注册cell。省略掉标识符的声明，使用类名来统一做标识符号
    ///
    /// 注意：`isCreateByNib`为`true`时，默认在主bundle且`cell`类名与`xib`文件名一致。如不一致，重写`EHReusable`的`nibInfo`方法返回正确信息
    /// - Parameters:
    ///   - cell: 注册的cell类型
    ///   - isCreateByNib: 是否通过Nib来创建Cell。
    func register<T: UITableViewCell>(cell: T.Type, isCreateByNib: Bool = false) where T: EHReusable {
        if isCreateByNib {
            let nib = UINib.init(nibName: T.nibInfo.name, bundle: T.nibInfo.bundle)
            base.register(nib, forCellReuseIdentifier: T.identifier)
        } else {
            base.register(cell, forCellReuseIdentifier: T.identifier)
        }
    }
    
    /// 创建cell，基于：func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell?
    func dequeueReusableCell<T: UITableViewCell>() -> T where T: EHReusable {
        guard let cell = base.dequeueReusableCell(withIdentifier: T.identifier) as? T else {
            fatalError("Could not dequeue reusable cell with identifier: \(T.identifier)")
        }
        return cell
    }
    
    /// 创建cell，基于：func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: EHReusable {
        guard let cell = base.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue reusable cell with identifier: \(T.identifier) indexPath: \(indexPath)")
        }
        return cell
    }
    
    /// 注册headerFooterView。省略掉标识符的声明，使用类名来统一做标识符号
    ///
    /// 注意：`isCreateByNib`为`true`时，默认在主bundle且`headerFooterView`类名与`xib`文件名一致。如不一致，重写`EHReusable`的`nibInfo`方法返回正确信息
    /// - Parameters:
    ///   - headerFooterView: 注册的headerFooterView类型
    ///   - isCreateByNib: 是否通过Nib来创建headerFooterView。
    func register<T: UITableViewHeaderFooterView>(headerFooterView: T.Type, isCreateByNib: Bool = false) where T: EHReusable {
        if isCreateByNib {
            let nib = UINib.init(nibName: T.nibInfo.name, bundle: T.nibInfo.bundle)
            base.register(nib, forHeaderFooterViewReuseIdentifier: T.identifier)
        } else {
            base.register(headerFooterView, forHeaderFooterViewReuseIdentifier: headerFooterView.identifier)
        }
    }
    
    /// 创建headerFooterView，基于：func dequeueReusableHeaderFooterView(withIdentifier identifier: String) -> UITableViewHeaderFooterView?
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T where T: EHReusable {
        guard let headerFooterView = base.dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as? T else {
            fatalError("Could not dequeue headerFooterView with identifier: \(T.identifier)")
        }
        return headerFooterView
    }
}
