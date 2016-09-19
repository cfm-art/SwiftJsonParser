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
 
    /// nullでないものをasNullした
    case NotNull

    /// 数値でないものをasNumberした
    case NotNumber
    
    /// ArrayObject.atに対して負数を指定した
    case NegativeIndex

    /// ArrayObject.atに対して要素数より大きい値を指定した
    case IndexOutOfBounds
    
    /// ObjectValue.atに対して存在しないキーを指定した
    case KeyNotFound
    
    /// Json文字列のフォーマットが不正
    case InvalidFormat
}