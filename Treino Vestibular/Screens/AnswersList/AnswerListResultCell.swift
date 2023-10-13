import UIKit
import SnapKit

class AnswerListResultCell: UITableViewCell {
    private let questionNumber: Int
    private let selectedAnswer: Character?
    private let correctAnswer: Character
    
    private lazy var questionNumberLabel: UILabel = {
        let uilabel = UILabel()
        uilabel.translatesAutoresizingMaskIntoConstraints = false
        return uilabel
    }()
    
    private lazy var buttons: [OptionButton] = {
        let arr: [Character] = ["a", "b", "c", "d", "e"]
        
        return arr.map { char in
            let button = OptionButton(char: char, action: { _ in })
            button.isEnabled = false
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }
    }()
    
    init(questionNumber: Int, selectedAnswer: Character?, correctAnswer: Character) {
        self.questionNumber = questionNumber
        self.selectedAnswer = selectedAnswer
        self.correctAnswer = correctAnswer
        
        super.init(style: .default, reuseIdentifier: nil)
        
        setupSubviews()
        checkButton(char: selectedAnswer)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("This should only be used programatically")
    }
    
    private func setupSubviews() {
        questionNumberLabel.text = getQuestionNumberLabelText()
        
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
    
    private func checkButton(char: Character?) {
        buttons.forEach { button in
            if button.char == char {
                button.check()
                return
            }
            
            button.uncheck()
        }
    }
    
    private func getQuestionNumberLabelText() -> String {
        let questionNumberText = String(questionNumber) + ". "
        
        if let selectedAnswer {
            let isCorrect = selectedAnswer == correctAnswer
            return questionNumberText + (isCorrect ? " ✅" : " ❌ \(correctAnswer)")
        }
        
        return questionNumberText + " 🔘"
    }
}

