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
    /// オブジェクト
    case kObject
    /// 配列
    case kArray
    /// 文字列
    case kString
    /// 数値
    case kNumber
    /// 真偽値
    case kBoolean
    /// null
    case kNull
    /// エラー
    case kError
}