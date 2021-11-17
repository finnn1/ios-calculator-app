//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var calculationHistoryScrollView: UIScrollView!
    @IBOutlet private weak var calculationHistoryStackView: UIStackView!
    @IBOutlet private weak var operandLabel: UILabel!
    @IBOutlet private weak var operatorLabel: UILabel!
    
    private var finalFormula = [String]()
    private var currentOperand: String = ""
    private var currentOperator: String = ""
    
    private var isCalculated: Bool = false
        
    private let maximumDigitsOfDoubleExpression = 16
    private let limitedDigitsOfExpression = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetCurrentOperand()
    }

    // MARK: - Private Methods
    private func resetToInitialState() {
        finalFormula = [String]()
        currentOperator = ""
        operatorLabel.text = ""
        isCalculated = false
        
        resetCurrentOperand()
        
        calculationHistoryStackView.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
    }

    private func resetCurrentOperand() {
        currentOperand = ""
        operandLabel.text = "0"
    }
    
    private func changeOperator(to newOperator: String) {
        guard !finalFormula.isEmpty else {
            return
        }
        
        operatorLabel.text = newOperator
        currentOperator = newOperator
        finalFormula[finalFormula.count - 1] = newOperator
    }
    
    private func addCalculationHistory(operandText: String, operatorText: String) {
        let sign = UILabel()
        sign.textColor = .white
        sign.text = operatorText
        sign.font = UIFont(name: "Helvetica", size: 24)
        
        let history = UILabel()
        history.text = operandText
        history.textColor = .white
        history.font = UIFont(name: "Helvetica", size: 24)
        
        let newHistoryStackView = UIStackView(arrangedSubviews: [sign, history])
        
        newHistoryStackView.axis = .horizontal
        newHistoryStackView.spacing = 10
        
        calculationHistoryStackView.addArrangedSubview(newHistoryStackView)
        
        autoScrollToBottom()
    }
    
    private func autoScrollToBottom() {
        calculationHistoryScrollView.layoutIfNeeded()
        
        let bottomOffset = CGPoint(x: 0, y: calculationHistoryScrollView.contentSize.height - calculationHistoryScrollView.bounds.height + calculationHistoryScrollView.contentInset.bottom)
        
        if bottomOffset.y > 0 {
            calculationHistoryScrollView.setContentOffset(bottomOffset, animated: true)
        }
    }
}

// MARK: - IBAction Methods
extension ViewController {
    @IBAction private func touchUpOperandButton(_ sender: UIButton) {
        if isCalculated {
            resetToInitialState()
        }
        
        guard let operand = sender.titleLabel?.text else {
            return
        }
                 
        guard currentOperand.count < limitedDigitsOfExpression else {
            return
        }
        
        currentOperand += operand
                
        currentOperand = currentOperand.replacingOccurrences(of: "^0+", with: "0", options: .regularExpression)
        
        var integerDigits = currentOperand
        var fractionDigits = ""
        
        if currentOperand.contains(".") {
            let splited = currentOperand.split(with: ".")
            integerDigits = splited.first ?? ""
            fractionDigits = splited.last ?? ""
        }
        
        if integerDigits.count > maximumDigitsOfDoubleExpression {
            operandLabel.text = Double(currentOperand)?.description
            return
        }
        
        guard let operandText = integerDigits.addCommaOnEveryThreeDigits() else {
            return
        }
        
        operandLabel.text = fractionDigits.isEmpty ? operandText : operandText + "." + fractionDigits
    }
    
    @IBAction func touchUpDotButton(_ sender: UIButton) {
        guard let dot = sender.titleLabel?.text else {
            return
        }
        
        guard !currentOperand.contains(dot) else {
            return
        }
        
        currentOperand += currentOperand.isEmpty ? "0\(dot)" : dot
        operandLabel.text?.append(dot)
    }
    
    @IBAction private func changePlusMinusSign(_ sender: Any) {
        guard let currentNumber = Double(currentOperand), !currentNumber.isZero else {
            return
        }
        
        guard let operandText = String(currentNumber * -1).addCommaOnEveryThreeDigits() else {
            return
        }
        
        if currentNumber.isSameAfterRounded() {
            currentOperand = String(Int(currentNumber * -1))
        } else {
            currentOperand = String(currentNumber * -1)
        }
        
        if abs(currentNumber) >= pow(10,Double(maximumDigitsOfDoubleExpression)) {
            operandLabel.text = String(currentNumber * -1)
        } else {
            operandLabel.text = operandText
        }
    }
    
    @IBAction private func touchUpOperatorButton(_ sender: UIButton) {
        guard let `operator` = sender.titleLabel?.text else {
            return
        }
    
        guard let currentNumber = Double(currentOperand), !currentNumber.isZero else {
            changeOperator(to: `operator`)
            return
        }
        
        guard let operandText = String(currentNumber).addCommaOnEveryThreeDigits() else {
            return
        }
        
        if abs(currentNumber) >= pow(10,Double(maximumDigitsOfDoubleExpression)) {
            addCalculationHistory(operandText: String(currentNumber), operatorText: currentOperator)
        } else {
            addCalculationHistory(operandText: operandText, operatorText: currentOperator)
        }
        
        finalFormula.append(currentOperand)
        finalFormula.append(`operator`)
        
        changeOperator(to: `operator`)        
        resetCurrentOperand()
    }
    
    @IBAction private func touchUpEqualButton(_ sender: Any) {
        guard !isCalculated else {
            return
        }
        
        isCalculated = true
        
        if !currentOperand.isEmpty && !currentOperator.isEmpty {
            guard let currentOperandText = currentOperand.addCommaOnEveryThreeDigits() else {
                return
            }
            
            guard let currentNumber = Double(currentOperand) else {
                return
            }
            
            if abs(currentNumber) >= pow(10,Double(maximumDigitsOfDoubleExpression)) {
                addCalculationHistory(operandText: String(currentNumber), operatorText: currentOperator)
            } else {
                addCalculationHistory(operandText: currentOperandText, operatorText: currentOperator)
            }
        }
        
        finalFormula.append(currentOperand)

        let formula = ExpressionParser.parse(from: finalFormula.joined(separator: " "))
        
        do {
            let calculationResult = try formula.result()
            guard let calculationResultText = calculationResult.description.addCommaOnEveryThreeDigits() else {
                return
            }
            
            resetCurrentOperand()
            operatorLabel.text = ""
            
            if abs(calculationResult) >= pow(10,Double(maximumDigitsOfDoubleExpression)) {
                operandLabel.text = String(calculationResult)
            } else {
                operandLabel.text = calculationResultText
            }
        } catch OperationError.dividedByZero {
            resetCurrentOperand()
            operandLabel.text = "NaN"
            operatorLabel.text = ""
        } catch CalculationItemQueueError.hasNoElement {
            print(CalculationItemQueueError.hasNoElement.localizedDescription)
        } catch {
            print(error)
        }
    }
    
    @IBAction private func touchUpACButton(_ sender: Any) {
        resetToInitialState()
    }
    
    @IBAction private func touchUpCEButton(_ sender: Any) {
        guard !isCalculated else {
            resetToInitialState()
            return
        }
        
        resetCurrentOperand()
    }
}
