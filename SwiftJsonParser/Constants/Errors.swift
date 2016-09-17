//
//  Errors.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/12.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

/// エラー
public enum Errors : ErrorType
{
    case NotNull
    case NotArray
    case NotObject
    case NotNumber
    
    case NegativeIndex
    case IndexOutOfBounds
    case KeyNotFound
}