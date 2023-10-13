import UIKit
import SnapKit

class AnswerListNoAnswerCell: UITableViewCell {
    private let questionNumber: Int
    
    private lazy var questionNumberLabel: UILabel = {
        let uilabel = UILabel()
        uilabel.translatesAutoresizingMaskIntoConstraints = false
        return uilabel
    }()
    
    private lazy var noAnswerLabel: UILabel = {
       let uilabel = UILabel()
        uilabel.text = "Sem resposta"
        uilabel.translatesAutoresizingMaskIntoConstraints = false
        return uilabel
    }()
    
    init(questionNumber: Int) {
        self.questionNumber = questionNumber
        
        super.init(style: .default, reuseIdentifier: nil)
        
        setupSubviews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("This should only be used programatically")
    }
    
    private func setupSubviews() {
        questionNumberLabel.text = String(questionNumber) + "."
        
        contentView.addSubview(questionNumberLabel)
        contentView.addSubview(noAnswerLabel)
        
        questionNumberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leadingMargin)
        }
        noAnswerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailingMargin)
        }
    }
}

