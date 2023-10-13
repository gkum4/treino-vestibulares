import UIKit

class OptionButton: UIButton {
    let char: Character
    let action: (Character) -> Void
    
    private lazy var view: UIView = {
        let uiview = UIView()
        uiview.translatesAutoresizingMaskIntoConstraints = false
        uiview.isUserInteractionEnabled = false
        return uiview
    }()
    
    private lazy var charLabel: UILabel = {
        let uilabel = UILabel()
        uilabel.translatesAutoresizingMaskIntoConstraints = false
        return uilabel
    }()
    
    private lazy var checkView: UIView = {
        let uiview = UIView()
        uiview.layer.borderColor = UIColor.black.cgColor
        uiview.layer.borderWidth = 1
        uiview.layer.cornerRadius = 7
        uiview.backgroundColor = .clear
        uiview.translatesAutoresizingMaskIntoConstraints = false
        return uiview
    }()
    
    init(char: Character, action: @escaping (Character) -> Void) {
        self.char = char
        self.action = action
        
        super.init(frame: .zero)
        
        addTarget(self, action: #selector(handlePress), for: .touchUpInside)
        
        setupSubViews()
    }
    required init?(coder: NSCoder) {
        fatalError("This should only be used programatically")
    }
    
    func check() {
        checkView.backgroundColor = .blue
    }
    
    func uncheck() {
        checkView.backgroundColor = .clear
    }
    
    @objc private func handlePress() {
        action(char)
    }
    
    private func setupSubViews() {
        view.addSubview(charLabel)
        view.addSubview(checkView)
        
        charLabel.text = String(char) + ")"
        
        charLabel.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.leading.equalTo(view.snp.leading)
        }
        checkView.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.leading.equalTo(charLabel.snp.trailing).offset(5)
            make.width.equalTo(14)
            make.height.equalTo(14)
        }
        
        addSubview(view)
        view.snp.makeConstraints { make in
            make.center.equalTo(snp.center)
            make.directionalEdges.equalTo(snp.directionalEdges)
        }
        snp.makeConstraints { make in
            make.trailing.equalTo(checkView.snp.trailing)
        }
    }
}
