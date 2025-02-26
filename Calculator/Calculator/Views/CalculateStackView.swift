import UIKit

final class CalculateStackView: UIStackView {
    
    init(`operator`: String, operand: String) {
        super.init(frame: .null)
        setLabels(with: `operator`, and: operand)
        setDefaultAttribute()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabels(with operatorText: String, and operandText: String) {
        let operatorLabel = createDefaultLabel(with: operatorText)
        let operandLabel = createDefaultLabel(with: operandText)
        self.addArrangedSubview(operatorLabel)
        self.addArrangedSubview(operandLabel)
    }
    
    func setDefaultAttribute() {
        self.spacing = 8
        self.alignment = .fill
        self.distribution = .fill
        self.axis = .horizontal
    }
    
    func createDefaultLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = UIColor.white
        label.textAlignment = .right
        label.text = text
        return label
    }
}
