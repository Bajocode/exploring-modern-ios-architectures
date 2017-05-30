/*
    VIPER Gameplan
    - Next: Wireframe setup
*/

import UIKit

// MARK: - Entity

protocol Parsable {}
struct Movie: Parsable {
    let title: String = ""
    let path: String = ""
}


// MARK: - Interactor
protocol ResultsInteractorInput {
    func fetchNewObjects()
}
protocol ResultsInteractorOutput: class {
    func receive(presentableObjects: [Parsable])
}
class MovieResultsInteractor: ResultsInteractorInput {
    weak var output: ResultsInteractorOutput!
    struct PresentableInstance: Parsable {
        let url: URL = URL(string: "")!
    }
    func fetchNewObjects() {
        // DataManager.fetch
        output.receive(presentableObjects: [PresentableInstance()])
    }
}


// MARK: - Presenter
protocol ResultsPresenterProtocol: class {
    func updateView()
}
class ResultsPresenter: ResultsPresenterProtocol, ResultsInteractorOutput {
    // properties
    weak var view: ResultsViewProtocol!
    var interactor: ResultsInteractorInput!
    
    
    // Presenter interface
    func updateView() {
        interactor.fetchNewObjects()
    }

    // InteractorOutput
    func receive(presentableObjects: [Parsable]) {
        view.update(presentableObjects: presentableObjects)
    }
}


// MARK: - View
protocol ResultsViewProtocol: class {
    func update(presentableObjects: [Parsable])
}
class ResultsViewController: UIViewController, ResultsViewProtocol {
    // Properties
    var presenter: ResultsPresenterProtocol!
    var collectionView: UICollectionView!
    fileprivate var presentableObjects = [Parsable]()
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Interactor fetches new presentable objects
        presenter.updateView()
    }
    
    // Methods
    func update(presentableObjects: [Parsable]) {
        self.presentableObjects = presentableObjects
    }
}





