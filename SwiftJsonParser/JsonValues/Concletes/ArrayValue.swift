//
//  ArrayValue.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/12.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

/// Jsonの配列
@objc
public class ArrayValue
    : NSObject, IArrayValue
{
    /// 
    private var values_: [JsonValue] = []
    
    /// 型
    /// - returns : 型
    public func typeOf() -> ValueType
    {
        return .kArray
    }
    
    ///
    public override init()
    {
    }
    
    ///
    /// - parameter array:
    public init(_ array: [JsonValue])
    {
        values_ = array
    }
    
    ///
    /// - returns : 
    public func array() -> [JsonValue]
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
    /// - parameter index:
    /// - returns
    public func at(index index: Int) -> JsonValue
    {
        if index < 0 { return ErrorValue(error: .NegativeIndex ) }
        if index >= values_.count { return ErrorValue(error: .IndexOutOfBounds ) }
        return values_[index]
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
    public func add(value: JsonValue)
    {
        values_.append(value)
    }
    
    /// 文字列として取得
    /// - returns : 文字列表現
    public func toStringValue() -> IStringValue
    {
        return StringValue(jsonString())
    }
    
    /// 数値(Double)として取得
    /// - returns : 数値表現
    public func toNumberValue() -> INumberValue
    {
        return ErrorValue(error: .NotNumber)
    }
    
    /// 真偽値(true/false)として取得
    /// - returns : 真偽値表現
    public func toBooleanValue() -> IBooleanValue
    {
        return BooleanValue(values_.count > 0)
    }
    
    /// nil
    /// null値でないものからの変換はエラーを返却
    /// - returns : nil
    public func toNullValue() -> INullValue
    {
        return ErrorValue(error: Errors.NotNull)
    }
    
    /// 配列[]として取得
    /// 配列以外からの変換はエラーを返却
    /// - returns : 配列
    public func toArrayValue() -> IArrayValue
    {
        return self
    }
    
    /// オブジェクト{}として取得
    /// オブジェクト以外からの変換はエラーを返却
    /// - returns : オブジェクト
    public func toObjectValue() -> IObjectValue
    {
        let o = ObjectValue()
        values_.enumerate().forEach { o.add($0.index.description, value: $0.element) }
        return o
    }

    /// Jsonでの文字列表現を取得する
    /// - returns : Jsonでの文字列表現
    public func jsonString() -> String
    {
        let result = NSMutableString(capacity: values_.count * 6)
        result.appendString("[")
        values_.forEach { result.appendString($0.jsonString()); result.appendString(",") }
        if result.hasSuffix(",") {
            result.replaceCharactersInRange(NSRange(location: result.length - 1, length: 1), withString: "]")
        } else {
            result.appendString("]")
        }
        return result as String
    }
}