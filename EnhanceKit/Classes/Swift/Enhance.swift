//
//  Enhance.swift
//  EnhanceKit
//
//  Created by lixinxing on 12/28/21.
//  Copyright © 2021 lixinxing. All rights reserved.
//

/**
 模仿RxSwift，为extension创建命名空间进行隔离，以方便使用和避免冲突。
 
 Use `Enhance` proxy as customization point for constrained protocol extensions.

 General pattern would be:

 // 1. Extend EnhanceCompatible protocol with constrain on Base
 // Read as: EnhanceWrapper Extension where Base is a SomeType
 extension EnhanceWrapper where Base == SomeType {
 // 2. Put any specific EnhanceCompatible extension for SomeType here
 }
 */
public struct EnhanceWrapper<Base> {
    /// Base object to extend.
    public let base: Base

    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) {
        self.base = base
    }
}

/// A type that has EnhanceCompatible extensions.
public protocol EnhanceCompatible { }

extension EnhanceCompatible {
    /// EnhanceWrapper extensions.
    public static var eh: EnhanceWrapper<Self>.Type {
        get { EnhanceWrapper<Self>.self }
        // this enables using EnhanceWrapper to "mutate" base type
        // swiftlint:disable:next unused_setter_value
        set { }
    }

    /// EnhanceWrapper extensions.
    public var eh: EnhanceWrapper<Self> {
        get { EnhanceWrapper(self) }
        // this enables using EnhanceWrapper to "mutate" base object
        // swiftlint:disable:next unused_setter_value
        set { }
    }
}


import Foundation

/// Extend NSObject with `eh` proxy.
extension NSObject: EnhanceCompatible { }




