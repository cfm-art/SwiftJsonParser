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
    func asString() -> IStringValue

    /// 数値(Double)として取得
    /// - returns : 数値表現
    func asNumber() -> INumberValue

    /// 真偽値(true/false)として取得
    /// - returns : 真偽値表現
    func asBoolean() -> IBooleanValue

    /// nil
    /// null値でないものからの変換はエラーを返却
    /// - returns : nil
    func asNull() -> INullValue

    /// 配列[]として取得
    /// 配列以外からの変換はエラーを返却
    /// - returns : 配列
    func asArray() -> IArrayValue

    /// オブジェクト{}として取得
    /// オブジェクト以外からの変換はエラーを返却
    /// - returns : オブジェクト
    func asObject() -> IObjectValue
    
    /// Jsonでの文字列表現を取得する
    /// - returns : Jsonでの文字列表現
    func jsonString() -> String

    /// オプションを指定してJsonでの文字列表現を取得する
    /// - parameters level :
    /// - parameters option :
    /// - returns : Jsonでの文字列表現
    func jsonString(level: Int, option: DeparseOptions) -> String
}

///　汎用処理
public extension JsonValue {
    /// asString().string()のエイリアス
    /// - returns : 文字列表現
    public func description() -> String
    {
        return asString().string()
    }
    
    /// 引数のタイプと同じかの判定
    /// - parameter type : 判定タイプ
    /// - returns : typeと同種ならtrue
    public func isTypeOf(type : ValueType) -> Bool
    {
        return typeOf() == type
    }
    
    /// エラーが発生しているかの判定
    /// - returns : エラーかどうか
    public func wasErrorOccured() -> Bool
    {
        return isTypeOf(.kError)
    }
    
    /// エラーとして取得
    /// - returns : エラー値
    public func asError() -> Errors
    {
        return ErrorValue.of(self)
    }
    
    /// 値がnullかの判定
    /// - returns : nullかどうか
    public func isNull() -> Bool
    {
        return isTypeOf(.kNull)
    }
}
