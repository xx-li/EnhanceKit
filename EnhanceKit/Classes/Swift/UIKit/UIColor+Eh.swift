//
//  UIColor+Eh.swift
//  Pods
//
//  Created by Stellar on 2022/3/1.
//

import Foundation

public extension EnhanceWrapper where Base == UIColor {
    
    /// 通过hex字符串创建颜色。创建失败返回默认颜色：lightGray
    ///
    /// 支持的类型：RGB, ARGB, #RGB, #ARGB, 0xRGB, 0xARGB
    /// - Parameter hex: HEX字符串
    /// - Returns: 颜色
    static func hexColor(_ hex: String) -> UIColor {
        var curHex: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (curHex.hasPrefix("#")) {
            curHex.remove(at: curHex.startIndex)
        } else if (curHex.hasPrefix("0X")) {
            curHex.remove(at: curHex.startIndex)
            curHex.remove(at: curHex.startIndex)
        }
        
        var argb:UInt64 = 0
        Scanner(string: curHex).scanHexInt64(&argb)
        if curHex.count == 6 {
            return UIColor(
                red: CGFloat((argb >> 16) & 0xFF) / 255.0,
                green: CGFloat((argb >> 8) & 0xFF) / 255.0,
                blue: CGFloat(argb & 0xFF) / 255.0,
                alpha: CGFloat(1.0)
            )
        } else if curHex.count == 8 {
            return UIColor(
                red: CGFloat((argb >> 16) & 0xFF) / 255.0,
                green: CGFloat((argb >> 8) & 0xFF) / 255.0,
                blue: CGFloat(argb & 0xFF) / 255.0,
                alpha: CGFloat((argb >> 24) & 0xFF) / 255.0
            )
        } else {
            print("\(#file)-\(#function) 错误的颜色字符串：\(hex)")
        }
        
        return .lightGray
    }
}
