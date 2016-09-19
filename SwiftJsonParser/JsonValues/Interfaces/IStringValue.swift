//
//  IStringValue.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/17.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

/// 文字列
@objc
public protocol IStringValue
    : JsonValue
{
    /// 中身をアンラップする
    /// - returns : 中身
    func string() -> String
}