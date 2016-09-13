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
    : NSObject, JsonValue
{
    /// エラー情報
    private var error_:Errors
    
    /// エラー情報を返却
    /// - returns エラー情報
    public func errorOf() -> Errors
    {
        return error_
    }
    
    /// エラー生成
    /// - parameter error : エラー情報
    /// - parameter isThrow : 例外を利用する
    public init(error : Errors, isThrow : Bool) throws
    {
        if isThrow {
            throw error
        }
        
        error_ = error
    }
}