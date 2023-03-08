//
//  BaseViewController.swift
//  APIBooks
//
//  Created by raul.santos on 08/02/23.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift


enum NavigationbarContentType {
    case text(text: String)
    case image(image: UIImage)
}

enum NavigationbarPosition {
    case right
    case left
}

class BaseViewController<CustomView: UIView>: UIViewController {
    
    
    internal let baseViewModel: BaseViewModelProtocol
    internal var disposeBag: DisposeBag!
    private var loadedFromNib: Bool = false

    init(viewModel: BaseViewModelProtocol, nibName: String) {
        baseViewModel = viewModel
        loadedFromNib = !nibName.isEmpty
        super.init(nibName: nibName, bundle: nil)
        modalPresentationStyle = .custom
    }

    init(viewModel: BaseViewModelProtocol) {
        baseViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
    }
    
    static func createAlertController(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        
        return alert
    }

    convenience required init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }

    var customView: CustomView! {
        return self.view as? CustomView
    }

    override func loadView() {
        if !loadedFromNib {
            self.view = CustomView()
        } else {
            super.loadView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.hidesBackButton = true

    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }

}

extension BaseViewController {

    private func removeBackButtonTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backButtonTitle = ""
    }
    
    @discardableResult public func addButtonOnNavigationBar(content: NavigationbarContentType, position: NavigationbarPosition, block: @escaping () -> Void) -> UIBarButtonItem {
        
        let barButtonItem: UIBarButtonItem
        switch content {
        case .text(let title):
            barButtonItem = UIBarButtonItem(title: title, style: .done, target: nil, action: nil)
        case .image(let image):
            barButtonItem = UIBarButtonItem(image: image, style: .done, target: nil, action: nil)
        }
        
        _ = barButtonItem.rx.tap
            .take(until: self.rx.deallocated)
            .subscribe(onNext: {(_) in
                block()
            })
        
        switch position {
        case .left:
            navigationItem.leftBarButtonItem = barButtonItem
        case .right:
            navigationItem.rightBarButtonItem = barButtonItem
        }
        
        return barButtonItem
    }
}
