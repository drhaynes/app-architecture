import UIKit

class MultiViewController: UIViewController, UITextFieldDelegate {
	
	let model = Model(value: "initial value")
	
	@IBOutlet var mvcTextField: UITextField!
	@IBOutlet var mvpTextField: UITextField!
	@IBOutlet var mvvmmTextField: UITextField!
	@IBOutlet var mvvmTextField: UITextField!
	@IBOutlet var mvcvsTextField: UITextField!
	@IBOutlet var mavbTextField: UITextField!
	@IBOutlet var cleanTextField: UITextField!
	
	@IBOutlet var mvcButton: UIButton!
	@IBOutlet var mvpButton: UIButton!
	@IBOutlet var mvvmmButton: UIButton!
	@IBOutlet var mvvmButton: UIButton!
	@IBOutlet var mvcvsButton: UIButton!
	@IBOutlet var mavbButton: UIButton!
	@IBOutlet var cleanButton: UIButton!
	
	@IBOutlet var stackView: UIStackView!

    // Strong references
    var mvcObserver: NSObjectProtocol?
    var presenter: ViewPresenter?

    var minimalObserver: NSObjectProtocol?
    var minimalViewModel: MinimalViewModel?

    var viewModel: ViewModel?
    var mvvmObserver: Cancellable?


	override func viewDidLoad() {
		super.viewDidLoad()
		
		mvcDidLoad()
		mvpDidLoad()
		mvvmMinimalDidLoad()
		mvvmDidLoad()
		mvcvsDidLoad()
		teaDidLoad()
		mavbDidLoad()
		cleanDidLoad()
	}
}


// MVC ---------------------------------------------------------

extension MultiViewController {
	func mvcDidLoad() {
        mvcTextField.text = model.value
        mvcObserver = NotificationCenter.default.addObserver(forName: Model.textDidChange, object: nil, queue: nil) { [mvcTextField] (note) in
            mvcTextField?.text = note.userInfo?[Model.textKey] as? String
        }
	}
	
	@IBAction func mvcButtonPressed() {
        model.value = mvcTextField?.text ?? ""
	}
}


// MVP ---------------------------------------------------------

protocol ViewProtocol: class {
    var textFieldValue: String { get set }
}

class ViewPresenter {
    let model: Model
    weak var view: ViewProtocol?
    let observer: NSObjectProtocol

    init(model: Model, view: ViewProtocol) {
        self.model = model
        self.view = view

        view.textFieldValue = model.value
        observer = NotificationCenter.default.addObserver(forName: Model.textDidChange, object: nil, queue: nil) { [view] (note) in
            view.textFieldValue = note.userInfo?[Model.textKey] as? String ?? ""
        }
    }

    func commit() {
        model.value = view?.textFieldValue ?? ""
    }
}

extension MultiViewController: ViewProtocol {
	func mvpDidLoad() {
        presenter = ViewPresenter(model: model, view: self)
	}

    var textFieldValue: String {
        get {
            return mvpTextField?.text ?? ""
        }

        set {
            mvpTextField?.text = newValue
        }
    }
	
	@IBAction func mvpButtonPressed() {
        presenter?.commit()
	}
}


// Minimal MVVM ---------------------------------------------------------

class MinimalViewModel: NSObject {
    let model: Model
    var observer: NSObjectProtocol?

    @objc dynamic var textFieldValue: String

    init(model: Model) {
        self.model = model
        textFieldValue = model.value
        super.init()
        observer = NotificationCenter.default.addObserver(forName: Model.textDidChange, object: nil, queue: nil) { [weak self] (note) in
            self?.textFieldValue = note.userInfo?[Model.textKey] as? String ?? ""
        }
    }

    func commit(value: String) {
        model.value = value
    }
}

extension MultiViewController {
	func mvvmMinimalDidLoad() {
        minimalViewModel = MinimalViewModel(model: model)
        minimalObserver = minimalViewModel?.observe(\.textFieldValue, options: [.initial, .new]) { [weak self] (_, change) in
            self?.mvvmmTextField?.text = change.newValue
        }
	}
	
	@IBAction func mvvmmButtonPressed() {
        minimalViewModel?.commit(value: mvvmmTextField?.text ?? "")
	}
}


// MVVM ---------------------------------------------------------

class ViewModel {
    let model: Model

    init(model: Model) {
        self.model = model
    }

    var textFieldValue: Signal<String> {
        return Signal.notifications(name: Model.textDidChange)
            .compactMap { note in
                note.userInfo?[Model.textKey] as? String
            }.continuous(initialValue: model.value)
    }

    func commit(value: String) {
        model.value = value
    }
}

extension MultiViewController {
	func mvvmDidLoad() {
        viewModel = ViewModel(model: model)
        mvvmObserver = viewModel?.textFieldValue.subscribeValues({ [unowned self] (text) in
            self.mvvmTextField?.text = text
        })

	}
    
	@IBAction func mvvmButtonPressed() {
        viewModel?.commit(value: mvvmTextField.text ?? "")
	}
}


// MVC+VS ---------------------------------------------------------

extension MultiViewController {
	func mvcvsDidLoad() {
	}
	
	@IBAction func mvcvsButtonPressed() {
	}
}


// TEA ---------------------------------------------------------

extension MultiViewController {
	func teaDidLoad() {
	}
}


// MAVB ---------------------------------------------------------

extension MultiViewController {
	func mavbDidLoad() {
	}
}


// "Clean" ---------------------------------------------------------

extension MultiViewController {
	func cleanDidLoad() {
	}

	@IBAction func cleanButtonPressed() {
	}
}
