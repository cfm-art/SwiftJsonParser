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
}