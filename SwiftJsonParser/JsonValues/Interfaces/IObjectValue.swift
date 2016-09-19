//
//  IObjectValue.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/17.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

///
@objc
public protocol IObjectValue
    : JsonValue
{
    
    ///　中身をアンラップする
    /// - returns : 中身
    func object() -> [String: JsonValue]
    
    /// 要素数
    /// - returns :
    func count() -> Int

    /// キーを指定して要素を取得
    /// - parameter key: キー
    /// - returns : 要素
    func at(key key: String) -> JsonValue
    
    /// キーを指定して要素を取得
    /// - parameter key: キー
    /// - returns : 要素
    subscript(key: String) -> JsonValue { get }
    
    /// 要素の追加
    /// - parameter key: キー
    /// - parameter value: 要素
    func add(key: String, value: JsonValue)


}