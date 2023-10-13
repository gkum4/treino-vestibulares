import UIKit
import SnapKit

class AnswersListVC: UITableViewController {
    var vestibular: Vestibular
    var questionsAnswers: [VestibularQuestion] = []
    var finished = false
    
    private lazy var finishBarButtonItem = UIBarButtonItem(
        title: "Finalizar",
        style: .plain,
        target: self,
        action: #selector(handleFinishPress)
    )
    private lazy var cleanBarButtonItem = UIBarButtonItem(
        title: "Limpar",
        style: .plain,
        target: self,
        action: #selector(handleCleanPress)
    )
    
    init(vestibular: Vestibular) {
        self.vestibular = vestibular
        self.questionsAnswers = vestibular.questions.map {
            VestibularQuestion(number: $0.number, answer: nil)
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("This should only be used programatically")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
    }
    
    private func setupNavBar() {
        title = vestibular.name
        navigationItem.rightBarButtonItem = finishBarButtonItem
    }
    
    @objc private func handleFinishPress() {
        setupAnswerInTitle(
            correctAnswers: getScore(),
            totalQuestions: getTotalQuestionsAnswered()
        )
        
        finished = true
        
        tableView.reloadData()
        
        navigationItem.rightBarButtonItem = cleanBarButtonItem
    }
    
    @objc private func handleCleanPress() {
        setupNavBar()
        
        cleanAnswers()
        
        finished = false
        
        tableView.reloadData()
    }
}

extension AnswersListVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vestibular.sections[section].questionsNumbersRange.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        return vestibular.sections[section].name
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return vestibular.sections.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let questionNumber = indexPath.row + vestibular
            .sections[indexPath.section]
            .questionsNumbersRange
            .lowerBound
        
        let cell: UITableViewCell
        
        if let correctAnswer = vestibular.questions[questionNumber - 1].answer {
            let selectedAnswer = questionsAnswers[questionNumber - 1].answer
            
            cell = finished ?
                AnswerListResultCell(
                    questionNumber: questionNumber,
                    selectedAnswer: selectedAnswer,
                    correctAnswer: correctAnswer
                ) :
                AnswerListCell(questionNumber: questionNumber, delegate: self)
        } else {
            cell = AnswerListNoAnswerCell(questionNumber: questionNumber)
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 75.0
    }
}

extension AnswersListVC: AnswerListCellDelegate {
    func setAnswer(_ answer: Character, forQuestion question: Int) {
        guard let index = questionsAnswers.firstIndex(where: { $0.number == question }) else {
            return
        }
        
        questionsAnswers[index].answer = answer
    }
}

extension AnswersListVC {
    private func getScore() -> Int {
        var correctAnswers = 0
        questionsAnswers.enumerated().forEach { (index, answer) in
            let correctAnswer = vestibular.questions[index].answer
            
            if correctAnswer == nil {
                return
            }
            
            if let chosenAnswer = answer.answer, chosenAnswer == correctAnswer {
                correctAnswers += 1
            }
        }
        
        return correctAnswers
    }
    
    private func getTotalQuestionsAnswered() -> Int {
        return questionsAnswers.reduce(0) { partialResult, question in
            if question.answer != nil {
                return partialResult + 1
            }
            
            return partialResult
        }
    }
    
    private func setupAnswerInTitle(correctAnswers: Int, totalQuestions: Int) {
        let isOne = correctAnswers == 1
        
        title = "\(correctAnswers) acerto\(isOne ? "" : "s") de \(totalQuestions)"
    }
}

extension AnswersListVC {
    private func cleanAnswers() {
        questionsAnswers.enumerated().forEach { (index, _) in
            questionsAnswers[index].answer = nil
        }
    }
}
