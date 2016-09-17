//
//  IArrayValue.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/17.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

///
@objc
public protocol IArrayValue
    : JsonValue
{
    ///
    /// - returns :
    func array() -> [JsonValue]
    
    ///
    /// - returns :
    func count() -> Int
    
    ///
    /// - parameter index:
    /// - returns
    func at(index index: Int) -> JsonValue
    
    ///
    subscript(index: Int) -> JsonValue { get }
    
    ///
    /// - paramter value:
    func add(value: JsonValue)
    
}