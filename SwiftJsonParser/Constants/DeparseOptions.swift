//
//  DeparseOption.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/19.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

/// Json文字列化の際のオプション
@objc
public class DeparseOptions
    : NSObject
{
    /// 改行の方法
    @objc
    public enum NewLine : Int
    {
        case kCrLf
        case kCr
        case kLf
        case kNone
    }
    
    /// タブ
    private var tab_ : String = "  "
    
    /// 改行
    private var newline_ : String = ""

    /// :の前のスペース
    private var beforeColon_ : String = ""

    /// :の後のスペース
    private var afterColon_ : String = ""
    
    /// タブの指定
    /// - parameter tab :
    /// - returns : self
    public func setTab(tab: String) -> DeparseOptions
    {
        tab_ = tab
        return self
    }
    
    /// 改行の指定
    /// - parameter newline :
    /// - returns : self
    public func setNewline(newline : NewLine) -> DeparseOptions
    {
        switch newline {
            case .kCrLf:
                newline_ = "\r\n"
                break
            case .kCr:
                newline_ = "\r"
                break
            case .kLf:
                newline_ = "\n"
                break
            default:
                newline_ = ""
                break
        }
        return self
    }
    
    /// ：の前後のスペース幅の指定
    /// - parameter beforeWidth :
    /// - parameter afterWidth :
    /// - returns :
    public func setColonSpace(before beforeWidth: Int, after afterWidth: Int ) -> DeparseOptions
    {
        let space: Character = " "
        beforeColon_ = String(count: beforeWidth, repeatedValue: space)
        afterColon_ = String(count: afterWidth, repeatedValue: space)
        return self
    }

    ///
    /// - returns :
    internal func tab() -> String
    {
        return tab_
    }
    
    ///
    /// - returns :
    internal func newline() -> String
    {
        return newline_
    }
    
    ///
    /// - returns :
    internal func beforeColon() -> String
    {
        return beforeColon_
    }
    
    ///
    /// - returns :
    internal func afterColon() -> String
    {
        return afterColon_
    }
}
