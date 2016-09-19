//
//  IArrayValue.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/17.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

/// 配列型
@objc
public protocol IArrayValue
    : JsonValue
{
    /// 中身をアンラップする
    /// - returns : 中身
    func array() -> [JsonValue]
    
    /// 要素数
    /// - returns :
    func count() -> Int
    
    /// 要素を取得
    /// - parameter index: 添字
    /// - returns
    func at(index index: Int) -> JsonValue
    
    /// 要素を取得
    /// - parameter index: 添字
    /// - returns
    subscript(index: Int) -> JsonValue { get }
    
    /// 要素の追加
    /// - paramter value:
    func add(value: JsonValue)
    
}