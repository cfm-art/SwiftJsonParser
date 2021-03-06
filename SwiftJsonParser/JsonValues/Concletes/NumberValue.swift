//
//  NumberValue.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/12.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

/// Jsonの数値
@objc
public class NumberValue
    : NSObject, INumberValue
{
    ///
    private var value_ : Double
    
    ///
    /// - returns :
    public func number() -> Double { return value_ }
    
    ///
    /// - parameter value:
    public init(_ value: Double = 0)
    {
        value_ = value
    }
    
    /// 型
    /// - returns : 型
    public func typeOf() -> ValueType
    {
        return .kNumber
    }
    
    /// 文字列として取得
    /// - returns : 文字列表現
    public func asString() -> IStringValue
    {
        return StringValue(value_.description)
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
        return BooleanValue(value_ != 0)
    }
    
    /// nil
    /// null値でないものからの変換はエラーを返却
    /// - returns : nil
    public func asNull() -> INullValue
    {
        return ErrorValue(error: Errors.NotNull)
    }

    /// 配列[]として取得
    /// - returns : 配列
    public func asArray() -> IArrayValue
    {
        let array = ArrayValue()
        array.add(self)
        return array
    }
    
    /// オブジェクト{}として取得
    /// - returns : オブジェクト
    public func asObject() -> IObjectValue
    {
        let object = ObjectValue()
        object.add("json", value: self)
        return object
    }
    
    /// Jsonでの文字列表現を取得する
    /// - returns : Jsonでの文字列表現
    public func jsonString() -> String
    {
        return value_.description
    }
    
    /// Jsonでの文字列表現を取得する
    /// - returns : Jsonでの文字列表現
    public func jsonString(level: Int, option: DeparseOptions) -> String
    {
        return jsonString()
    }
}