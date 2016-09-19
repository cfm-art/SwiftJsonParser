//
//  StringValue.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/12.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

/// Jsonの文字列値
@objc
public class StringValue
    : NSObject, IStringValue
{
    ///
    private var value_ : String
    
    ///
    /// - returns :
    public func string() -> String { return value_ }

    ///
    /// - parameter value:
    public init(_ value: String = "")
    {
        value_ = value
    }
    
    /// 型
    /// - returns : 型
    public func typeOf() -> ValueType
    {
        return .kString
    }
    
    /// 文字列として取得
    /// - returns : 文字列表現
    public func asString() -> IStringValue
    {
        return self;
    }
    
    /// 数値(Double)として取得
    /// - returns : 数値表現
    public func asNumber() -> INumberValue
    {
        if let v: Double = Double(value_) {
            return NumberValue(v)
        }
        return ErrorValue(error: Errors.NotNumber)
    }
    
    /// 真偽値(true/false)として取得
    /// - returns : 真偽値表現
    public func asBoolean() -> IBooleanValue
    {
        return BooleanValue(value_ == "true")
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
        return "\"" + JsonEscaper.escape(value_) + "\""
    }
    
    /// Jsonでの文字列表現を取得する
    /// - returns : Jsonでの文字列表現
    public func jsonString(level: Int, option: DeparseOptions) -> String
    {
        return jsonString()
    }
}