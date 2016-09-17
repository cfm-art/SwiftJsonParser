//
//  SwiftJsonParserTests.swift
//  SwiftJsonParserTests
//
//  Created by あると on 2016/09/12.
//  Copyright © 2016年 あると. All rights reserved.
//

import XCTest
@testable import SwiftJsonParser

class SwiftJsonParser_JsonValuesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    //-- String
    
    // json文字列表現のエスケープ
    func testStringJsonValue() {
        // \ " / \n \r \b \f \t \uXXXX
        
        var s = StringValue("\\test\"test/")
        XCTAssertEqual(s.jsonString(), "\"\\\\test\\\"test\\/\"")
        
        s = StringValue("\n\r\ttest")
        XCTAssertEqual(s.jsonString(), "\"\\n\\r\\ttest\"")
        
        s = StringValue("\u{0008}\u{000c}")
        XCTAssertEqual(s.jsonString(), "\"\\b\\f\"")
        
        s = StringValue("\\uabcd")
        XCTAssertEqual(s.jsonString(), "\"\\uabcd\"")

        s = StringValue("\\uabcg")
        XCTAssertEqual(s.jsonString(), "\"\\\\uabcg\"")
    }
    
    /// string -> number
    func testStringToNumber() {
        var s = StringValue("2.00")
        var n = s.toNumberValue()
        XCTAssertTrue(n.number() == 2.0)

        s = StringValue("notnumber")
        n = s.toNumberValue()
        XCTAssertTrue(n.typeOf() == .kError,
                        (n.typeOf().rawValue.description + "/" + ValueType.kError.rawValue.description))
    }
    
    /// string -> boolean
    func testStringToBoolean() {
        var s = StringValue("true")
        var b = s.toBooleanValue()
        XCTAssertTrue(b.boolean())
        
        s = StringValue("notboolean")
        b = s.toBooleanValue()
        XCTAssertFalse(b.boolean())
    }
    
    /// string -> null
    func testStringToNull() {
        let s = StringValue("")
        let n = s.toNullValue()
        XCTAssertTrue(n.typeOf() == .kError)
    }
    
    // string -> array
    func testStringToArray() {
        let s = StringValue("")
        let a = s.toArrayValue()
        XCTAssertTrue(a.typeOf() == .kError)
    }
    
    // string -> object
    func testStringToObject() {
        let s = StringValue("")
        let o = s.toObjectValue()
        XCTAssertTrue(o.typeOf() == .kError)
    }
    

    //-- Number

    /// number -> string
    func testNumberToString() {
        let n = NumberValue(1.0)
        let s = n.toStringValue()
        XCTAssertTrue(s.string() == "1.0")
    }
    
    /// number -> boolean
    func testNumberToBoolean() {
        var n = NumberValue(1.0)
        var b = n.toBooleanValue()
        XCTAssertTrue(b.boolean())
        
        n = NumberValue(0)
        b = n.toBooleanValue()
        XCTAssertFalse(b.boolean())
    }
    
    /// number -> null
    func testNumberToNull() {
        let o = NumberValue(1)
        let n = o.toNullValue()
        XCTAssertTrue(n.typeOf() == .kError)
    }
    
    // number -> array
    func testNumberToArray() {
        let n = NumberValue(1)
        let a = n.toArrayValue()
        XCTAssertTrue(a.typeOf() == .kError)
    }
    
    // number -> object
    func testNumberToObject() {
        let n = NumberValue(1)
        let o = n.toObjectValue()
        XCTAssertTrue(o.typeOf() == .kError)
    }

    
    //-- Boolean
    
    /// boolean -> number
    func testBooleanToNumber() {
        var s = BooleanValue(true)
        var n = s.toNumberValue()
        XCTAssertTrue(n.number() == 1.0)
        
        s = BooleanValue(false)
        n = s.toNumberValue()
        XCTAssertTrue(n.number() == 0.0)
    }
    
    /// boolean -> string
    func testBooleanToString() {
        var s = BooleanValue(true)
        var b = s.toStringValue()
        XCTAssertTrue(b.string() == "true")
        
        s = BooleanValue(false)
        b = s.toStringValue()
        XCTAssertTrue(b.string() == "false", b.string())
    }
    
    /// boolean -> null
    func testBooleanToNull() {
        let s = BooleanValue(false)
        let n = s.toNullValue()
        XCTAssertTrue(n.typeOf() == .kError)
    }
    
    // boolean -> array
    func testBooleanToArray() {
        let s = BooleanValue(false)
        let a = s.toArrayValue()
        XCTAssertTrue(a.typeOf() == .kError)
    }
    
    // boolean -> object
    func testBooleanToObject() {
        let s = BooleanValue(false)
        let o = s.toObjectValue()
        XCTAssertTrue(o.typeOf() == .kError)
    }


    
    //-- Null
    
    /// null -> number
    func testNullToNumber() {
        let s = NullValue()
        let n = s.toNumberValue()
        XCTAssertTrue(n.typeOf() == .kNull)
    }
    
    /// null -> string
    func testNullToString() {
        let s = NullValue()
        let b = s.toStringValue()
        XCTAssertTrue(b.typeOf() == .kNull)
    }
    
    /// Null -> boolean
    func testNullToBoolean() {
        let s = NullValue()
        let n = s.toBooleanValue()
        XCTAssertTrue(n.typeOf() == .kNull)
    }
    
    // null -> array
    func testNullToArray() {
        let s = NullValue()
        let a = s.toArrayValue()
        XCTAssertTrue(a.typeOf() == .kNull)
    }
    
    // null -> object
    func testNullToObject() {
        let s = NullValue()
        let o = s.toObjectValue()
        XCTAssertTrue(o.typeOf() == .kNull)
    }

    
    //-- Array
    
    /// array -> number
    func testArrayToNumber() {
        let s = ArrayValue()
        s.add(NullValue())
        let n = s.toNumberValue()
        XCTAssertTrue(n.typeOf() == .kError)
    }
    
    /// array -> string
    func testArrayToString() {
        let s = ArrayValue()
        s.add(StringValue("a"))
        s.add(NumberValue(2))
        let b = s.toStringValue()
        XCTAssertEqual(b.string(), "[\"a\",2.0]")
    }
    
    /// array -> boolean
    func testArrayToBoolean() {
        let s = ArrayValue()
        var n = s.toBooleanValue()
        XCTAssertTrue(n.boolean() == false)
        
        s.add(NullValue())
        n = s.toBooleanValue()
        XCTAssertTrue(n.boolean())
    }
    
    // array -> null
    func testArrayToNull() {
        let s = ArrayValue()
        let a = s.toNullValue()
        XCTAssertTrue(a.typeOf() == .kError)
    }
    
    // array -> object
    func testArrayToObject() {
        let s = ArrayValue()
        s.add(StringValue("a"))
        s.add(NumberValue(1))
        let o = s.toObjectValue()
        XCTAssertEqual(o.at(key: "0").toStringValue().string(), "a")
        XCTAssertEqual(o.at(key: "1").toNumberValue().number(), 1)
    }

    
    //-- Array
    
    /// object -> number
    func testObjectToNumber() {
        let s = ObjectValue()
        s.add("key", value: NullValue())
        let n = s.toNumberValue()
        XCTAssertTrue(n.typeOf() == .kError)
    }
    
    /// object -> string
    func testObjectToString() {
        let s = ObjectValue()
        s.add("key1", value: StringValue("a"))
        s.add("key2", value: NumberValue(2))
        let b = s.toStringValue()
        XCTAssertEqual(b.string(), "{\"key1\":\"a\",\"key2\":2.0}")
    }
    
    /// object -> boolean
    func testObjectToBoolean() {
        let s = ObjectValue()
        var n = s.toBooleanValue()
        XCTAssertTrue(n.boolean() == false)
        
        s.add("key", value: NullValue())
        n = s.toBooleanValue()
        XCTAssertTrue(n.boolean())
    }
    
    // object -> null
    func testObjectToNull() {
        let s = ObjectValue()
        let a = s.toNullValue()
        XCTAssertTrue(a.typeOf() == .kError)
    }
    
    // object -> array
    func testObjectToArray() {
        let s = ObjectValue()
        s.add("key", value: StringValue("a"))
        s.add("i", value: NumberValue(1))
        let o = s.toArrayValue()
        
        XCTAssertEqual(o.at(index: 0).toStringValue().string(), "a")
        XCTAssertEqual(o.at(index: 1).toNumberValue().number(), 1)
    }
}
