//
//  ExpressionParserTests.swift
//  CalculatorTests
//
//  Created by Lingo on 2022/03/18.
//

import XCTest
@testable import Calculator

final class ExpressionParserTests: XCTestCase {
  
  func test_parse_주어진_입력후_호출시_formula_operands_elements는_1_2_음수1의_배열을_반환해야한다() {
    // given
    let input = "1 + 2 × -1"
    // when
    let formula = ExpressionParser.parse(from: input)
    let output = formula.operands.elements
    // then
    XCTAssertEqual(output, [1.0, 2.0, -1.0])
  }
  
  func test_parse_주어진_입력후_호출시_formula_operators_elements는_add_multiply의_배열을_반환해야한다() {
    // given
    let input = "1 + 2 × -1"
    // when
    let formula = ExpressionParser.parse(from: input)
    let output = formula.operators.elements
    // then
    XCTAssertEqual(output, [.add, .multiply])
  }
  
  func test_parse_주어진_입력후_호출시_formula의_result는_음수3을_반환해야한다() {
    // given
    let input = "1 + 2 × -1"
    // when
    var formula = ExpressionParser.parse(from: input)
    let output = try! formula.result()
    // then
    XCTAssertEqual(output, -3.0)
  }
  
  func test_parse_주어진_입력후_호출시_formula의_result는_NaN을_반환해야한다() {
    // given
    let input = "1 + 2 ÷ 0"
    // when
    var formula = ExpressionParser.parse(from: input)
    let output = try! formula.result()
    // then
    XCTAssertTrue(output.isNaN)
  }
  
  func test_parse_미완성된_사용자_입력후_호출시_formula의_result는_Error를_던져야한다() {
    // given
    let input = "1 + 2 - "
    // when
    var formula = ExpressionParser.parse(from: input)
    // then
    XCTAssertThrowsError(try formula.result())
  }
}
