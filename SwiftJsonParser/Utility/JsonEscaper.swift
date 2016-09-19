//
//  JsonEscaper.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/17.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

/// json用にエスケープする
@objc
public class JsonEscaper
    : NSObject
{
    
    /// jsonのリテラルに入るようにエスケープを行う
    /// - paramter value: エスケープ元
    /// - returns : エスケープ後
    public static func escape(value: String) -> String
    {
        // 対象文字
        // \ " / \n \r \b \f \t \uXXXX

        // 以下に置き換える
        //   \\   "   /  \n  \r  \u{0008}  \u{000c}  \t \uXXXX
        // \\\\ \\" \\/ \\n \\r       \\b       \\f \\t \uXXXX
        
        // \をそのまま\\に置き換えると\uXXXXが\\uXXXXになるので注意
        
        let result = NSMutableString(capacity: value.characters.count)

        for i in value.startIndex..<value.endIndex {
            let c = value[i]
            switch c {
                case "\\", "/", "\"":
                    result.appendString("\\\(c)")
                    break;
                case "\n":
                    result.appendString("\\n")
                    break;
                case "\r":
                    result.appendString("\\r")
                    break;
                case "\t":
                    result.appendString("\\t")
                    break;
                case "\u{0008}":
                    result.appendString("\\b")
                    break;
                case "\u{000c}":
                    result.appendString("\\f")
                    break;
                default:
                    result.appendString("\(c)")
                    break;
            }
        }

        let pattern = "\\\\(u[¥da-fA-F]{4})"
        let replace = "$1"
        return result.stringByReplacingOccurrencesOfString(pattern,
                                                           withString: replace,
                                                           options: NSStringCompareOptions.RegularExpressionSearch,
                                                           range: NSRange(location: 0, length: result.length))
        
        /*
        var result: String
        result = value.stringByReplacingOccurrencesOfString("\\", withString: "\\\\")       // \
        result = result.stringByReplacingOccurrencesOfString("/", withString: "\\/")        // /
        result = result.stringByReplacingOccurrencesOfString("\"", withString: "\\\"")      // "
        result = result.stringByReplacingOccurrencesOfString("\n", withString: "\\n")       // ¥n
        result = result.stringByReplacingOccurrencesOfString("\r", withString: "\\r")       // ¥r
        result = result.stringByReplacingOccurrencesOfString("\t", withString: "\\t")       // ¥t
        result = result.stringByReplacingOccurrencesOfString("\u{0008}", withString: "\\b") // ¥b
        result = result.stringByReplacingOccurrencesOfString("\u{000c}", withString: "\\f") // ¥f
        
        let pattern = "\\\\(u[¥da-fA-F]{4})"
        let replace = "$1"
        result = result.stringByReplacingOccurrencesOfString(pattern,
                                                             withString: replace,
                                                             options: NSStringCompareOptions.RegularExpressionSearch,
                                                             range: nil)
        return result*/
    }
}