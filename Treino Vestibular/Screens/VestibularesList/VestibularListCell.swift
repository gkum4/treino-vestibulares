import UIKit
import SnapKit

class VestibularListCell: UITableViewCell {
    let name: String
    
    init(name: String) {
        self.name = name
        
        super.init(style: .default, reuseIdentifier: nil)
        
        setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("This should only be used programatically")
    }
    
    private lazy var nameLabel: UILabel = {
        let uilabel = UILabel()
        uilabel.translatesAutoresizingMaskIntoConstraints = false
        return uilabel
    }()
    
    func setupSubviews() {
        nameLabel.text = name
        
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(snp_leadingMargin)
            make.centerY.equalTo(snp_centerYWithinMargins)
        }
    }
}
