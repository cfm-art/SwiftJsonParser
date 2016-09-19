//
//  INumberValue.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/17.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

/// 数値型
@objc
public protocol INumberValue
    : JsonValue
{
    /// 中身をアンラップする
    /// - returns : 中身
    func number() -> Double
}