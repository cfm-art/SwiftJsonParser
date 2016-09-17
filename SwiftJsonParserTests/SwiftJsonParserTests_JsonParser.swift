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
        
        XCTAssertEqual(result.toObjectValue().at(key: "v").toStringValue().string(), "test")
        XCTAssertEqual(result.toObjectValue().at(key: "testkey").toNumberValue().number(), 1)
    }
    
    func testParseArray() {
        let json = " [\"v\",\"test\", \"testkey\"   ,  1.0]"
        let parser = JsonParser().setJsonText(json)
        let result = parser.parse()
        
        XCTAssertEqual(result.toArrayValue().at(index: 0).toStringValue().string(), "v")
        XCTAssertEqual(result.toArrayValue().at(index: 1).toStringValue().string(), "test")
        XCTAssertEqual(result.toArrayValue().at(index: 2).toStringValue().string(), "testkey")
        XCTAssertEqual(result.toArrayValue().at(index: 3).toNumberValue().number(), 1.0)
    }
}