/*
    VIPER Gameplan
    - Next: Wireframe setup
*/

import UIKit

// MARK: - Entity

protocol Transportable {}
struct Movie: Transportable {
    let title: String = ""
    let path: String = ""
}


// MARK: - Interactor
protocol ResultsInteractorInterface {
    func fetchNewObjects()
}
protocol ResultsInteractorOutput: class {
    func receive(presentableObjects: [Transportable])
}
class MovieResultsInteractor: ResultsInteractorInterface {
    weak var output: ResultsInteractorOutput!
    struct PresentableInstance: Transportable {
        let url: URL = URL(string: "")!
    }
    func fetchNewObjects() {
        // DataManager.fetch
        output.receive(presentableObjects: [PresentableInstance()])
    }
}


// MARK: - Presenter
protocol ResultsPresenterInterface: class {
    func updateView()
}
class ResultsPresenter: ResultsPresenterInterface, ResultsInteractorOutput {
    // properties
    weak var view: ResultsViewProtocol!
    var interactor: ResultsInteractorInterface!
    
    
    // Presenter interface
    func updateView() {
        interactor.fetchNewObjects()
    }

    // InteractorOutput
    func receive(presentableObjects: [Transportable]) {
        view.update(presentableObjects: presentableObjects)
    }
}


// MARK: - View
protocol ResultsViewProtocol: class {
    func update(presentableObjects: [Transportable])
}
class ResultsViewController: UIViewController, ResultsViewProtocol {
    // Properties
    var presenter: ResultsPresenterInterface!
    var collectionView: UICollectionView!
    fileprivate var presentableObjects = [Transportable]()
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Interactor fetches new presentable objects
        presenter.updateView()
    }
    
    // Methods
    func update(presentableObjects: [Transportable]) {
        self.presentableObjects = presentableObjects
    }
}





