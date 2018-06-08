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
//    var mvcObserver: NSObjectProtocol?
//    var presenter: ViewPresenter?
//
//    var minimalViewModel: MinimalViewModel?
//    var minimalObserver: NSObjectProtocol?
//
//    var viewModel: ViewModel?
//    var mvvmObserver: Cancellable?
//
//    var viewState: ViewState?
//    var viewStateModelObserver: NSObjectProtocol?
//    var viewStateObserver: NSObjectProtocol?
//
//    var driver: Driver<TEAState, TEAState.Action>?
//
//    var viewStateAdapter: Var<String>!
//
//    var cleanPresenter: CleanPresenter!

    
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
	}
	
	@IBAction func mvcButtonPressed() {
	}
}


// MVP ---------------------------------------------------------

extension MultiViewController {
	func mvpDidLoad() {
	}
	
	@IBAction func mvpButtonPressed() {
	}
}


// Minimal MVVM ---------------------------------------------------------

extension MultiViewController {
	func mvvmMinimalDidLoad() {
	}
	
	@IBAction func mvvmmButtonPressed() {
	}
}


// MVVM ---------------------------------------------------------

extension MultiViewController {
	func mvvmDidLoad() {
	}
    
	@IBAction func mvvmButtonPressed() {
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
		cleanPresenter.commit()
	}
}
