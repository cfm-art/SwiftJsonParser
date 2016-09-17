//
//  IObjectValue.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/17.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

///
@objc
public protocol IObjectValue
    : JsonValue
{
    
    ///
    /// - returns :
    func object() -> [String: JsonValue]
    
    ///
    /// - returns :
    func count() -> Int

    ///
    /// - parameter ket:
    /// - returns
    func at(key key: String) -> JsonValue
    
    ///
    subscript(key: String) -> JsonValue { get }
    
    ///
    /// - paramter value:
    func add(key: String, value: JsonValue)


}