//
//  NullValue.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/12.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

/// JsonのNull値
@objc
public class NullValue
    : NSObject
    , IStringValue
    , INumberValue
    , IBooleanValue
    , INullValue
    , IArrayValue
    , IObjectValue
{
    /// 型
    /// - returns : 型
    public func typeOf() -> ValueType
    {
        return .kNull
    }
    
    /// 文字列として取得
    /// - returns : 文字列表現
    public func asString() -> IStringValue
    {
        return self
    }
    
    /// 数値(Double)として取得
    /// - returns : 数値表現
    public func asNumber() -> INumberValue
    {
        return self
    }
    
    /// 真偽値(true/false)として取得
    /// - returns : 真偽値表現
    public func asBoolean() -> IBooleanValue
    {
        return self
    }
    
    /// nil
    /// null値でないものからの変換はエラーを返却
    /// - returns : nil
    public func asNull() -> INullValue
    {
        return self
    }
    
    /// 配列[]として取得
    /// 配列以外からの変換はエラーを返却
    /// - returns : 配列
    public func asArray() -> IArrayValue
    {
        return self
    }
    
    /// オブジェクト{}として取得
    /// オブジェクト以外からの変換はエラーを返却
    /// - returns : オブジェクト
    public func asObject() -> IObjectValue
    {
        return self
    }

    /// Jsonでの文字列表現を取得する
    /// - returns : Jsonでの文字列表現
    public func jsonString() -> String
    {
        return "null"
    }
    
    //--
    public func string() -> String { return "" }
    public func number() -> Double { return Double.NaN }
    public func boolean() -> Bool { return false }
    
    //-- object
    
    ///
    /// - returns :
    public func object() -> [String: JsonValue]
    {
        return [:]
    }
    
    ///
    /// - returns :
    public func count() -> Int
    {
        return 0
    }
    
    ///
    /// - parameter ket:
    /// - returns
    public func at(key key: String) -> JsonValue
    {
        return self
    }
    
    ///
    public subscript(key: String) -> JsonValue
        {
        get {
            return at(key:key)
        }
    }
    
    ///
    /// - paramter value:
    public func add(key: String, value: JsonValue) {}
    
    //-- array
    ///
    /// - returns :
    public func array() -> [JsonValue]
    {
        return []
    }
    
    ///
    /// - parameter index:
    /// - returns
    public func at(index index: Int) -> JsonValue
    {
        return self
    }
    
    ///
    public subscript(index: Int) -> JsonValue
        {
        get {
            return at(index: index)
        }
    }
    
    ///
    /// - paramter value:
    public func add(value: JsonValue) {}
}