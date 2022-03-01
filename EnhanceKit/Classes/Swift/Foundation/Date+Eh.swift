//
//  Date+Eh.swift
//  Pods
//
//  Created by Stellar on 2022/3/1.
//

import Foundation

extension Date: EnhanceCompatible { }

public extension EnhanceWrapper where Base == Date {
    /// 把Date对象格式化成对应格式的字符串
    /// - Parameter format: 格式化规则。如：`yyyy-MM-dd HH:mm:ss`
    /// - Returns: 日期格式化后的字符串
    func format(_ format:String) -> String {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = format
        return dfmatter.string(from: base)
    }
    
    /// 获取当前日期是星期几。
    ///
    /// 注：返回值为1～7，依次代表从周日到周六。例如，周日为1，周一为2
    /// - Returns: 代表星期几的数字
    func weekday() -> Int {
        let calender = NSCalendar.autoupdatingCurrent
        return calender.component(.weekday, from: base)
    }
}


