import UIKit
import SnapKit

class VestibularesListVC: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Provas"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Vestibulares.shared.vestibulares.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vestibular = Vestibulares.shared.vestibulares[indexPath.row]
        let cell = VestibularListCell(name: vestibular.name)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vestibular = Vestibulares.shared.vestibulares[indexPath.row]
        let answersListVC = AnswersListVC(vestibular: vestibular)
        
        show(answersListVC, sender: self)
    }
}

