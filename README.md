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
