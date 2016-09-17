//
//  BooleanValue.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/12.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

/// Jsonの真偽値
@objc
public class BooleanValue
    : NSObject, IBooleanValue
{
    ///
    private var value_ : Bool

    ///
    /// - returns :
    public func boolean() -> Bool { return value_ }
    
    ///
    /// - parameter value:
    public init(_ value: Bool = false)
    {
        value_ = value
    }
    
    /// 型
    /// - returns : 型
    public func typeOf() -> ValueType
    {
        return .kBoolean
    }
    
    /// 文字列として取得
    /// - returns : 文字列表現
    public func toStringValue() -> IStringValue
    {
        return StringValue(value_.description)
    }
    
    /// 数値(Double)として取得
    /// - returns : 数値表現
    public func toNumberValue() -> INumberValue
    {
        return NumberValue(value_ ? 1 : 0)
    }
    
    /// 真偽値(true/false)として取得
    /// - returns : 真偽値表現
    public func toBooleanValue() -> IBooleanValue
    {
        return self
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
        return ErrorValue(error: Errors.NotArray)
    }
    
    /// オブジェクト{}として取得
    /// オブジェクト以外からの変換はエラーを返却
    /// - returns : オブジェクト
    public func toObjectValue() -> IObjectValue
    {
        return ErrorValue(error: Errors.NotObject)
    }
    
}