//
//  ObjectValue.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/12.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

/// Jsonのオブジェクト
@objc
public class ObjectValue
    : NSObject, IObjectValue
{
    ///
    private var values_: [String: JsonValue] = [:]
    
    /// 型
    /// - returns : 型
    public func typeOf() -> ValueType
    {
        return .kObject
    }
    
    ///
    /// - returns :
    public func object() -> [String: JsonValue]
    {
        return values_
    }
    
    ///
    /// - returns :
    public func count() -> Int
    {
        return values_.count
    }
    
    ///
    /// - parameter ket:
    /// - returns
    public func at(key key: String) -> JsonValue
    {
        if let v = values_[key] {
            return v
        }
        return ErrorValue(error: .KeyNotFound)
    }
    
    ///
    public subscript(key: String) -> JsonValue
        {
        get {
            return at(key: key)
        }
    }
    
    ///
    /// - paramter value:
    public func add(key: String, value: JsonValue)
    {
        values_[key] = value
    }
    
    /// 文字列として取得
    /// - returns : 文字列表現
    public func asString() -> IStringValue
    {
        return StringValue(jsonString())
    }
    
    /// 数値(Double)として取得
    /// - returns : 数値表現
    public func asNumber() -> INumberValue
    {
        return ErrorValue(error: .NotNumber)
    }
    
    /// 真偽値(true/false)として取得
    /// - returns : 真偽値表現
    public func asBoolean() -> IBooleanValue
    {
        return BooleanValue(values_.count > 0)
    }
    
    /// nil
    /// null値でないものからの変換はエラーを返却
    /// - returns : nil
    public func asNull() -> INullValue
    {
        return ErrorValue(error: Errors.NotNull)
    }
    
    /// 配列[]として取得
    /// 配列以外からの変換はエラーを返却
    /// - returns : 配列
    public func asArray() -> IArrayValue
    {
        return ArrayValue(values_.flatMap { $1 })
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
        let result = NSMutableString(capacity: values_.count * 12)
        result.appendString("{")
        values_.forEach {
            result.appendString("\"")
            result.appendString($0.0);
            result.appendString("\":")
            result.appendString($0.1.jsonString())
            result.appendString(",")
        }
        if result.hasSuffix(",") {
            result.replaceCharactersInRange(NSRange(location: result.length - 1, length: 1), withString: "}")
        } else {
            result.appendString("}")
        }
        return result as String
    }
}