//
//  IStringValue.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/17.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

///
@objc
public protocol IStringValue
    : JsonValue
{
    func string() -> String
}