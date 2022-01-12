//
//  String+Eh.swift
//  EnhanceKit
//
//  Created by lixinxing on 2021/12/29.
//  Copyright © 2021 lixinxing. All rights reserved.

import Foundation


extension String: EnhanceCompatible { }

// MARK: - 正则表达式验证相关

public extension EnhanceWrapper where Base == String {
    
    /// 截取字符串子串。传入错误的截取位置会返回nil
    /// - Parameters:
    ///   - from: 字符串起使位置
    ///   - to: 字符串结束位置
    /// - Returns: 截取的字符串子串
    func substring(from: Int, to: Int) -> String? {
        guard to >= from && from >= 0 && to < base.count else {
            return nil
        }
        let startIdx = base.index(base.startIndex, offsetBy: from)
        let endIdx = base.index(base.startIndex, offsetBy: to)
        return String(base[startIdx...endIdx])
    }
}


// MARK: - 正则表达式验证相关
public extension EnhanceWrapper where Base == String {
    
    /// 是否能匹配正则表达式
    /// - Parameter pattern: 正则表达式
    /// - Returns: 匹配结果，能匹配返回true，不能匹配返回false
    func isMatchPattern(_ pattern: String) -> Bool {
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", pattern)
        let isMatch = predicate.evaluate(with: self.base)
        return isMatch
    }
    
    /// 是否是手机号码。
    /// - Note: 1开头的11位数字即符合规则
    var isPhoneNumber: Bool {
        return isMatchPattern("^1+\\d{10}")
    }
    
    /// 是否是邮箱地址
    var isEmail: Bool {
        let pattern = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        return isMatchPattern(pattern)
    }
    
    /// 是否是身份证号码
    /// 15位身份证号码验证：6位行政区划代码 + 6位出生日期码(yyMMdd) + 3位顺序码
    /// 18位身份证号码验证：6位行政区划代码 + 8位出生日期码(yyyyMMdd) + 3位顺序码 + 1位校验码
    func isIDCardNumber() -> Bool {
        let regex = "(^\\d{15}$)|(^\\d{17}([0-9]|X)$)"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regex])
        let provinceCodes = [
            "11", "12", "13", "14", "15",
            "21", "22", "23",
            "31", "32", "33", "34", "35", "36", "37",
            "41", "42", "43", "44", "45", "46",
            "50", "51", "52", "53", "54",
            "61", "62", "63", "64", "65",
            "71", "81", "82", "91"]
        
        // 初步验证
        guard predicate.evaluate(with: self) else {
            return false
        }
        // 验证省份代码。如果需要更精确的话，可以把前六位行政区划代码都列举出来比较。
        let provinceCode = String(self.base.prefix(2))
        guard provinceCodes.contains(provinceCode) else {
            return false
        }
        // 验证身份证号码
        // 15位身份证号码验证：6位行政区划代码 + 6位出生日期码(yyMMdd) + 3位顺序码
        // 18位身份证号码验证：6位行政区划代码 + 8位出生日期码(yyyyMMdd) + 3位顺序码 + 1位校验码
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        var birthdate: String
        if self.base.count == 15 {
            birthdate = "19\(self.substring(from: 6, to: 11)!)"
        } else {
            birthdate = self.substring(from: 6, to: 13)!
        }
        guard let _ = dateFormatter.date(from: birthdate) else {
            return false
        }
        
        // 18位身份证号码验证校验位
        if self.base.count == 18 {
            let weights = [7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2]
            let validationCodes = ["1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2"]
            
            // 验证校验位
            let digits = self.substring(from: 0, to: 16)!.map { Int("\($0)")! }
            var sum = 0
            for i in 0..<weights.count {
                sum += weights[i] * digits[i]
            }
            let mod11 = sum % 11
            let validationCode = validationCodes[mod11]
            return base.hasSuffix(validationCode)
        }
        
        return true
    }
}


