//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    private let calculatorManager = CalculatorManager(isCalculating: false)
    
    @IBOutlet weak var formulaeScrollView: UIScrollView!
    @IBOutlet weak var formulaeStackView: UIStackView!
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var operandLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initOperandLabel()
        initOperatorLabel()
        initformulaeStackView()
    }
}

// MARK: - Actions

extension ViewController {
    @IBAction private func touchUpDigit(_ sender: UIButton) {
        guard let currentOperandLabelTitle = operandLabel.text else {
            return
        }
        
        guard let currentOperandButtonTitle = sender.currentTitle else {
            return
        }
    
        if currentOperandLabelTitle == "0" {
            operandLabel.text = currentOperandButtonTitle
        } else {
            operandLabel.text = currentOperandLabelTitle + currentOperandButtonTitle
        }
    }
    
    @IBAction private func touchUpOperator(_ sender: UIButton) {
        guard let currentOperandButtionTitle = sender.currentTitle else {
            return
        }
        
        operatorLabel.text = currentOperandButtionTitle
    }
    
    @IBAction private func touchUpAllClear(_ sender: UIButton) {
        initAllDisplay()
    }
    
    @IBAction private func touchUpClearError(_ sender: UIButton) {
        
    }
    
    @IBAction private func touchUpSignConversion(_ sender: UIButton) {
        guard let currentOperandLabelTitle = operandLabel.text else {
            return
        }
        
        guard currentOperandLabelTitle != "0" else {
            return
        }
        
        let convertedOperand = convertSign(from: currentOperandLabelTitle)
        operandLabel.text = convertedOperand
    }
    
    @IBAction private func touchUPEqualSign(_ sender: UIButton) {
        
    }
}

// MARK: - private Methods

extension ViewController {
    func initOperatorLabel() {
        operatorLabel.text = ""
    }
    
    func initOperandLabel() {
        operandLabel.text = "0"
    }
    
    func initformulaeStackView() {
        formulaeStackView.arrangedSubviews.forEach { $0.removeFromSuperview()}
    }
    
    func initAllDisplay() {
        initOperatorLabel()
        initOperandLabel()
        initformulaeStackView()
    }
    
    func appendFormulaToFormulae(`operator`: String, operand: String) {
        let formulaStackView: UIStackView = UIStackView()
        let operatorLabel: UILabel = UILabel()
        let operandLabel: UILabel = UILabel()
        
        operatorLabel.text = `operator`
        operandLabel.text = operand
        
        formulaStackView.axis = .horizontal
        formulaStackView.alignment = .fill
        formulaStackView.spacing = 8
        
        formulaStackView.addSubview(operatorLabel)
        formulaStackView.addSubview(operandLabel)
        
        formulaeStackView.addSubview(formulaStackView)
    }
    
    func convertSign(from operand: String) -> String {
        guard let sign = operand.first, sign == "-" else {
            return "-" + operand
        }
        let signIndex: String.Index = operand.index(operand.startIndex, offsetBy: 1)
        return String(operand[signIndex...])
    }
}
