import UIKit
import SnapKit

protocol AnswerListCellDelegate {
    func setAnswer(_ answer: Character, forQuestion question: Int)
}

class AnswerListCell: UITableViewCell {
    private let delegate: AnswerListCellDelegate?
    private let questionNumber: Int
    
    private lazy var questionNumberLabel: UILabel = {
        let uilabel = UILabel()
        uilabel.translatesAutoresizingMaskIntoConstraints = false
        return uilabel
    }()
    
    private lazy var buttons: [OptionButton] = {
        let arr: [Character] = ["a", "b", "c", "d", "e"]
        
        return arr.map { char in
            let button = OptionButton(char: char, action: handleButtonPress)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }
    }()
    
    init(questionNumber: Int, delegate: AnswerListCellDelegate) {
        self.questionNumber = questionNumber
        self.delegate = delegate
        
        super.init(style: .default, reuseIdentifier: nil)
        
        setupSubviews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("This should only be used programatically")
    }
    
    private func setupSubviews() {
        questionNumberLabel.text = String(questionNumber) + "."
        
        contentView.addSubview(questionNumberLabel)
        buttons.forEach { button in
            contentView.addSubview(button)
        }
        
        questionNumberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leadingMargin)
        }
        
        guard var lastButton = buttons.last else {
            return
        }
        lastButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailingMargin)
        }
        buttons.dropLast().reversed().forEach { button in
            button.snp.makeConstraints { make in
                make.centerY.equalTo(contentView.snp.centerY)
                make.trailing.equalTo(lastButton.snp.leading).offset(-13)
            }

            lastButton = button
        }
    }
    
    private func handleButtonPress(char: Character) {
        delegate?.setAnswer(char, forQuestion: questionNumber)
        
        checkButton(char: char)
    }
    
    private func checkButton(char: Character?) {
        buttons.forEach { button in
            if button.char == char {
                button.check()
                return
            }
            
            button.uncheck()
        }
    }
}
