//
//  Formula.swift
//  Calculator
//
//  Created by marisol on 2022/03/18.
//

struct Formula {
    var operands: CalculatorItemQueue<Double>
    var operators: CalculatorItemQueue<Operator>
    
    mutating func result() throws -> Double {
        var formulaResult = operands.dequeue() ?? .zero

        while operands.isEmpty == false {
            guard let number = operands.dequeue(),
                  let operatorData = operators.dequeue()
            else {
                throw CalculatorError.invalidFormula
            }
            
            if number == .zero, operatorData == .division {
                throw CalculatorError.divisionByZero
            }
            
            formulaResult = operatorData.calculate(lhs: formulaResult, rhs: number)
        }
        
        let splited = String(formulaResult).split(with: .plus)

        if splited.count == 2, let digit = Int(splited[1]), digit > 20 {
            throw CalculatorError.overMaximumDigit
        }
        
        return formulaResult
    }
}
