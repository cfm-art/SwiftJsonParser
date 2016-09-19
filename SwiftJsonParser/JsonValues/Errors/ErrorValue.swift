//
//  ErrorValue.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/13.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

// エラー
@objc
public class ErrorValue
    : NullValue
{
    ///
    private let error_: Errors
    
    ///
    /// - returns : エラー
    public func error() -> Errors
    {
        return error_
    }
    
    ///
    /// - parameter error:
    public init(error: Errors)
    {
        error_ = error
    }
    
    /// 型
    /// - returns : 型
    public override func typeOf() -> ValueType { return .kError }

    ///
    public override func jsonString() -> String {
        return ""
    }
    
    ///
    public override func jsonString(level: Int, option: DeparseOptions) -> String {
        return ""
    }
    
    ///
    /// - parameter error :
    /// - returns
    public static func of(error: JsonValue) -> Errors
    {
        return error.wasErrorOccured()
                    ? (error as! ErrorValue).error()
                    : Errors.NoError
    }
}
