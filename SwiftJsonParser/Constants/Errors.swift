//
//  Errors.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/12.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

/// エラー
@objc
public enum Errors : Int
{
    case NoError
    
    case NotNull
    case NotNumber
    
    case NegativeIndex
    case IndexOutOfBounds
    case KeyNotFound
    
    case InvalidFormat
}