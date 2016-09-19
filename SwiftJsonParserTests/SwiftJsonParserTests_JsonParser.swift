//
//  SwiftJsonParserTests_JsonParser.swift
//  SwiftJsonParser
//
//  Created by あると on 2016/09/18.
//  Copyright © 2016年 あると. All rights reserved.
//

import XCTest
@testable import SwiftJsonParser

class SwiftJsonParser_JsonParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParseObject() {
        let json = "  {\"v\":\"test\", \"testkey\"   :  1.0}"
        let parser = JsonParser().setJsonText(json)
        let result = parser.parse()
        
        XCTAssertEqual(result.asObject().at(key: "v").asString().string(), "test")
        XCTAssertEqual(result.asObject().at(key: "testkey").asNumber().number(), 1)
        XCTAssert(result.asObject().at(key: "invalidkey").wasErrorOccured())
        XCTAssertEqual(ErrorValue.of(result.asObject().at(key: "invalidkey")), Errors.KeyNotFound)
    }
    
    func testParseArray() {
        let json = " [\"v\",\"test\", \"testkey\"   ,  1.0]"
        let parser = JsonParser().setJsonText(json)
        let result = parser.parse()
        
        XCTAssertEqual(result.asArray().at(index: 0).asString().string(), "v")
        XCTAssertEqual(result.asArray().at(index: 1).asString().string(), "test")
        XCTAssertEqual(result.asArray().at(index: 2).asString().string(), "testkey")
        XCTAssertEqual(result.asArray().at(index: 3).asNumber().number(), 1.0)
    }
    
    func testDeparseObject() {
        let root = ObjectValue()
        root.add("key1", value: StringValue("value1"))
        root.add("key2", value: NumberValue(1.0))
        
        let options = DeparseOptions().setTab("  ").setNewline(.kCrLf)
        let deparser = JsonDeparser().setJsonObject(root).setOptions(options)
        
        let result = deparser.deparse()
        XCTAssertEqual(result, "{\r\n  \"key1\":\"value1\",\r\n  \"key2\":1.0\r\n}")
    }
}