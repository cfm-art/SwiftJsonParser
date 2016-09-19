//
//  JsonDeparser.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/19.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

/// JsonオブジェクトをJson文字列へ変換
@objc
public class JsonDeparser
    : NSObject
{
    ///
    private var options_ = DeparseOptions()
    
    ///
    private var target_: JsonValue? = nil
    
    ///
    private var result_: String? = nil
    
    /// Json文字列化する対象の指定
    /// - parameter jsonObject: 対象
    /// - returns : self
    public func setJsonObject(jsonObject: JsonValue) -> JsonDeparser
    {
        result_ = nil
        target_ = jsonObject
        return self
    }
    
    /// 変換オプションを指定する
    /// - paramter options: オプション
    /// - returns : self
    public func setOptions(options: DeparseOptions) -> JsonDeparser
    {
        result_ = nil
        options_ = options
        return self
    }

    /// Json文字列へ
    /// - returns : 結果
    public func deparse() -> String
    {
        if let r = result_ {
            return r
        }
        if let t = target_ {
            let result = t.jsonString(0, option: options_)
            result_ = result
            return result
        } else {
            return ""
        }
    }
    
    ///
    /// - parameter options :
    /// - parameter level :
    /// - parameter output :
    internal static func tab(options: DeparseOptions, level: Int, output: NSMutableString)
    {
        if !options.tab().isEmpty && !options.newline().isEmpty {
            for _ in 0..<level {
                output.appendString(options.tab())
            }
        }
    }

    ///
    /// - parameter options :
    /// - parameter output :
    internal static func newline(options: DeparseOptions, output: NSMutableString)
    {
        if !options.newline().isEmpty {
            output.appendString(options.newline())
        }
    }
}