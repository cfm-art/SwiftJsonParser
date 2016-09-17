//
//  JsonValue.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/12.
//  Copyright © 2016年 あると. All rights reserved.
//

import Foundation

/// Jsonの各値を表現するクラスの基底
@objc
public protocol JsonValue
{
    /// 型
    /// - returns : 型
    func typeOf() -> ValueType
    
    /// 文字列として取得
    /// - returns : 文字列表現
    func toStringValue() -> IStringValue

    /// 数値(Double)として取得
    /// - returns : 数値表現
    func toNumberValue() -> INumberValue

    /// 真偽値(true/false)として取得
    /// - returns : 真偽値表現
    func toBooleanValue() -> IBooleanValue

    /// nil
    /// null値でないものからの変換はエラーを返却
    /// - returns : nil
    /// - throws : nullでない
    func toNullValue() -> INullValue

    /// 配列[]として取得
    /// 配列以外からの変換はエラーを返却
    /// - returns : 配列
    /// - throws : 配列でない
    func toArrayValue() -> IArrayValue

    /// オブジェクト{}として取得
    /// オブジェクト以外からの変換はエラーを返却
    /// - returns : オブジェクト
    /// - throws : オブジェクトでない
    func toObjectValue() -> IObjectValue
}
