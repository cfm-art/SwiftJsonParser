//
//  ValueType.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/12.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

/// 値の種別
@objc
public enum ValueType : Int
{
    ///
    case kObject
    ///
    case kArray
    ///
    case kString
    ///
    case kNumber
    ///
    case kBoolean
    ///
    case kNull
}