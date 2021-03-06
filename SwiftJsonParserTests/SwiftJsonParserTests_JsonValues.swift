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
        var n = s.asNumber()
        XCTAssertTrue(n.number() == 2.0)

        s = StringValue("notnumber")
        n = s.asNumber()
        XCTAssertTrue(n.typeOf() == .kError,
                        (n.typeOf().rawValue.description + "/" + ValueType.kError.rawValue.description))
    }
    
    /// string -> boolean
    func testStringToBoolean() {
        var s = StringValue("true")
        var b = s.asBoolean()
        XCTAssertTrue(b.boolean())
        
        s = StringValue("notboolean")
        b = s.asBoolean()
        XCTAssertFalse(b.boolean())
    }
    
    /// string -> null
    func testStringToNull() {
        let s = StringValue("")
        let n = s.asNull()
        XCTAssertTrue(n.typeOf() == .kError)
    }
    
    // string -> array
    func testStringToArray() {
        let s = StringValue("aa")
        let a = s.asArray()
        XCTAssertEqual(a.at(index: 0).asString().string(), s.string())
    }
    
    // string -> object
    func testStringToObject() {
        let s = StringValue("bb")
        let o = s.asObject()
        XCTAssertEqual(o.at(key: "json").asString().string(), s.string())
    }
    

    //-- Number

    /// number -> string
    func testNumberToString() {
        let n = NumberValue(1.0)
        let s = n.asString()
        XCTAssertTrue(s.string() == "1.0")
    }
    
    /// number -> boolean
    func testNumberToBoolean() {
        var n = NumberValue(1.0)
        var b = n.asBoolean()
        XCTAssertTrue(b.boolean())
        
        n = NumberValue(0)
        b = n.asBoolean()
        XCTAssertFalse(b.boolean())
    }
    
    /// number -> null
    func testNumberToNull() {
        let o = NumberValue(1)
        let n = o.asNull()
        XCTAssertTrue(n.typeOf() == .kError)
    }
    
    // number -> array
    func testNumberToArray() {
        let n = NumberValue(2)
        let a = n.asArray()
        XCTAssertEqual(a.at(index: 0).asNumber().number(), n.number())
    }
    
    // number -> object
    func testNumberToObject() {
        let n = NumberValue(3)
        let o = n.asObject()
        XCTAssertEqual(o.at(key: "json").asNumber().number(), n.number())
    }

    
    //-- Boolean
    
    /// boolean -> number
    func testBooleanToNumber() {
        var s = BooleanValue(true)
        var n = s.asNumber()
        XCTAssertTrue(n.number() == 1.0)
        
        s = BooleanValue(false)
        n = s.asNumber()
        XCTAssertTrue(n.number() == 0.0)
    }
    
    /// boolean -> string
    func testBooleanToString() {
        var s = BooleanValue(true)
        var b = s.asString()
        XCTAssertTrue(b.string() == "true")
        
        s = BooleanValue(false)
        b = s.asString()
        XCTAssertTrue(b.string() == "false", b.string())
    }
    
    /// boolean -> null
    func testBooleanToNull() {
        let s = BooleanValue(false)
        let n = s.asNull()
        XCTAssertTrue(n.typeOf() == .kError)
    }
    
    // boolean -> array
    func testBooleanToArray() {
        let s = BooleanValue(true)
        let a = s.asArray()
        XCTAssertEqual(a.at(index: 0).asBoolean().boolean(), s.boolean())
    }
    
    // boolean -> object
    func testBooleanToObject() {
        let s = BooleanValue(true)
        let o = s.asObject()
        XCTAssertEqual(o.at(key: "json").asBoolean().boolean(), s.boolean())
    }


    
    //-- Null
    
    /// null -> number
    func testNullToNumber() {
        let s = NullValue()
        let n = s.asNumber()
        XCTAssertTrue(n.typeOf() == .kNull)
    }
    
    /// null -> string
    func testNullToString() {
        let s = NullValue()
        let b = s.asString()
        XCTAssertTrue(b.typeOf() == .kNull)
    }
    
    /// Null -> boolean
    func testNullToBoolean() {
        let s = NullValue()
        let n = s.asBoolean()
        XCTAssertTrue(n.typeOf() == .kNull)
    }
    
    // null -> array
    func testNullToArray() {
        let s = NullValue()
        let a = s.asArray()
        XCTAssertTrue(a.typeOf() == .kNull)
    }
    
    // null -> object
    func testNullToObject() {
        let s = NullValue()
        let o = s.asObject()
        XCTAssertTrue(o.typeOf() == .kNull)
    }

    
    //-- Array
    
    /// array -> number
    func testArrayToNumber() {
        let s = ArrayValue()
        s.add(NullValue())
        let n = s.asNumber()
        XCTAssertTrue(n.typeOf() == .kError)
    }
    
    /// array -> string
    func testArrayToString() {
        let s = ArrayValue()
        s.add(StringValue("a"))
        s.add(NumberValue(2))
        let b = s.asString()
        XCTAssertEqual(b.string(), "[\"a\",2.0]")
    }
    
    /// array -> boolean
    func testArrayToBoolean() {
        let s = ArrayValue()
        var n = s.asBoolean()
        XCTAssertTrue(n.boolean() == false)
        
        s.add(NullValue())
        n = s.asBoolean()
        XCTAssertTrue(n.boolean())
    }
    
    // array -> null
    func testArrayToNull() {
        let s = ArrayValue()
        let a = s.asNull()
        XCTAssertTrue(a.typeOf() == .kError)
    }
    
    // array -> object
    func testArrayToObject() {
        let s = ArrayValue()
        s.add(StringValue("a"))
        s.add(NumberValue(1))
        let o = s.asObject()
        XCTAssertEqual(o.at(key: "0").asString().string(), "a")
        XCTAssertEqual(o.at(key: "1").asNumber().number(), 1)
    }

    
    //-- Array
    
    /// object -> number
    func testObjectToNumber() {
        let s = ObjectValue()
        s.add("key", value: NullValue())
        let n = s.asNumber()
        XCTAssertTrue(n.typeOf() == .kError)
    }
    
    /// object -> string
    func testObjectToString() {
        let s = ObjectValue()
        s.add("key1", value: StringValue("a"))
        s.add("key2", value: NumberValue(2))
        let b = s.asString()
        XCTAssertEqual(b.string(), "{\"key1\":\"a\",\"key2\":2.0}")
    }
    
    /// object -> boolean
    func testObjectToBoolean() {
        let s = ObjectValue()
        var n = s.asBoolean()
        XCTAssertTrue(n.boolean() == false)
        
        s.add("key", value: NullValue())
        n = s.asBoolean()
        XCTAssertTrue(n.boolean())
    }
    
    // object -> null
    func testObjectToNull() {
        let s = ObjectValue()
        let a = s.asNull()
        XCTAssertTrue(a.typeOf() == .kError)
    }
    
    // object -> array
    func testObjectToArray() {
        let s = ObjectValue()
        s.add("key", value: StringValue("a"))
        s.add("i", value: NumberValue(1))
        let o = s.asArray()
        
        XCTAssertEqual(o.at(index: 0).asString().string(), "a")
        XCTAssertEqual(o.at(index: 1).asNumber().number(), 1)
    }
}
