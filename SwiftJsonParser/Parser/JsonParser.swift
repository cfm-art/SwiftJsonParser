//
//  JsonParser.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/12.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

/// Jsonの解析を行いJsonValueを返すパーサー
@objc
public class JsonParser
    : NSObject
{
    /// オプション
    private var options_: [ParseOption] = []

    /// 対象文字列
    private var json_: String = ""
    
    /// パース結果
    private var result_: JsonValue? = nil
    
    ///
    /// - parameter json:
    /// - returns : self
    public func setJsonText(json: String) -> JsonParser
    {
        result_ = nil
        json_ = json
        return self
    }
    
    ///
    /// - paramter options:
    /// - returns : self
    public func setOption(options: [ParseOption]) -> JsonParser
    {
        result_ = nil
        options_ = options
        return self
    }
    
    ///
    /// - returns :
    public func parse() -> JsonValue
    {
        if let r = result_ {
            return r
        }
        var index = json_.startIndex
        return parseImpl(&index)
    }
    
    private func parseImpl(inout index: String.Index) -> JsonValue
    {
        index = skipSpace(index)
        let c = json_[index]

        if c == "[" {
            index = skipSpace(index.successor())
            let o = ArrayValue()
            while json_[index] != "]" {
                o.add(parseImpl(&index))
                index = skip(index, target: [",", "]"])
                if json_[index] == "," { index = index.successor() }
            }
            return o
        } else if c == "{" {
            index = skipSpace(index.successor())
            let o = ObjectValue()
            while json_[index] != "}" {
                let i = skip(index, target: ["\""]).successor()
                index = skipLiteral(i)
                let key = json_.substringWithRange(i..<index)
                index = skip(index.successor(), target: [":"]).successor()
                o.add(key, value: parseImpl(&index))
                index = skip(index, target: [",", "}"])
                if json_[index] == "," { index = index.successor() }
            }
            return o
        } else {
            // string/number/boolean/null
            if c == "n" {
                // null
                return parseConstant(&index, key: "null", value: NullValue())
            } else if c == "t" {
                // true
                return parseConstant(&index, key: "true", value: BooleanValue(true))
            } else if c == "f" {
                // false
                return parseConstant(&index, key: "false", value: BooleanValue(false))
            } else if c == "\"" {
                // "string" -> \"を除く"まで
                let i = index.successor()
                let e = skipLiteral(i)
                index = e.successor()
                return StringValue(json_.substringWithRange(i..<e))
            } else if c >= "0" && c <= "9" {
                // 0-9
                let i = index
                index = skipExclude(index, target: ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."])
                return StringValue(json_.substringWithRange(i..<index)).toNumberValue()
            } else {
                index = json_.endIndex
                return ErrorValue(error: .InvalidFormat)
            }
        }
    }
    
    private func parseConstant(inout index: String.Index, key: String, value: JsonValue) -> JsonValue
    {
        let next = index.advancedBy(key.characters.count)
        let r = json_.compare(key, options: [], range: index..<next, locale: nil)
        if r != .OrderedSame {
            index = json_.endIndex
            return ErrorValue(error: .InvalidFormat)
        }
        index = next
        return value
    }
    
    private func skipLiteral(index: String.Index) -> String.Index
    {
        var i = index
        let end = json_.endIndex
        var isEscape : Bool = false
        var isEscaping : Bool = false
        while i != end {
            let c = json_[i]
            if !isEscaping { isEscape = false }
            isEscaping = false
            if c == "\\" {
                isEscape = true
                isEscaping = true
            } else if !isEscape && c == "\"" {
                return i
            }
            i = i.successor()
        }
        return i
    }
    
    private func skip(index: String.Index, target: [Character]) -> String.Index
    {
        var i = index
        let end = json_.endIndex
        while i != end {
            let c = json_[i]
            if target.contains(c) {
                return i
            }
            i = i.successor()
        }
        return i
    }

    private func skipExclude(index: String.Index, target: [Character]) -> String.Index
    {
        var i = index
        let end = json_.endIndex
        while i != end {
            let c = json_[i]
            if !target.contains(c) {
                return i
            }
            i = i.successor()
        }
        return i
    }
    
    private func skipSpace(index: String.Index) -> String.Index
    {
        var i = index
        let end = json_.endIndex
        while i != end {
            let c = json_[i]
            if c > " " {
                return i
            }
            i = i.successor()
        }
        return i
    }
}
