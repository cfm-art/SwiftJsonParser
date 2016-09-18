# SwiftのJsonパーサ
swift向けにJsonをオブジェクト化する簡易パーサ。

# 使い方
``` 使い方
let jsonText = "{\"v\":\"test\", \"testkey\":1.0}"

let parser = JsonParser()
parser.setJsonText(jsonText)
let result:JsonValue = parser.parse()
let root = result.asObject()

// print test
print(root.at(key: "v").asString().string())

// print 1.0
print(root.at(key: "testkey").asNumber().number().description)
```

各Json型毎にasXxxx()メソッドを使った相互変換が可能です。
(が、Numberのように精度によって必ず同じになるとは限りません。)

変換不能な場合はErrorValue型へ置き換わります。

# エラー処理
``` エラー処理
// キーがないErroValueが返却
let error = root.at(key: "invalidkey")

// エラーか判定する
// true
print(error.isTypeOf(.kError))
// true
print(error.wasErrorOccured())

// エラーの種別を判定する
// true
print(error.asError() == Erros.KeyNotFound)
```

# 型変換対応表
| 変換元 | 変換先 | 結果 |
|:-----------|------------:|:------------:|
|String|Number|Double(値)なNumberへ、無理であればErrors.NotNumber|
|String|Boolean|"true"ならtrueそれ以外はfalseなBooleanへ|
|String|Null|常にErrors.NotNull|
|String|Array|要素数1なArrayへ|
|String|Object|"json"をキーに持つ要素数1なObjectへ|
|Number|String|値.descriptionなStringへ|
|Number|Boolean|1ならtrue、他はfalseなBooleanへ|
|Number|Null|常にErrors.NotNull|
|Number|Array|要素数1なArrayへ|
|Number|Object|"json"をキーに持つ要素数1なObjectへ|
|Boolean|String|"true","false"なStringへ|
|Boolean|Number|1もしくは0なNumber|
|Boolean|Null|常にErros.NotNull|
|Boolean|Array|要素数1なArrayへ|
|Boolean|Object|"json"をキーに持つ要素数1なObjectへ|
|Array|String|Json文字列表現なString|
|Array|Number|常にErros.NotNumber|
|Array|Boolean|要素数が１以上ならtrueなBoolean|
|Array|Null|常にErrors.NotNull|
|Array|Object|添字をキーにした連想配列へ|
|Object|String|Json文字列表現なStringへ|
|Object|Number|常にErrors.NotNumber|
|Object|Boolean|要素数が1以上ならtrueなBooleanへ|
|Object|Null|常にErrors.NotNull|
|Object|Array|flatMapを行ったArray|
|Null|他の型|常にNull|
|Error|他の型|常にError|