//
//  BaseViewModel.swift
//  APIBooks
//
//  Created by raul.santos on 08/02/23.
//

import Foundation
import RxSwift
import RxCocoa

protocol BaseViewModelProtocol {
    
    var toastSuccess: Observable<String> { get }
    var toastError: Observable<String> { get }
}

class BaseViewModel: NSObject {
    
    internal let toastErrorSubject = PublishSubject<String>()
    internal let toastSuccessSubject = PublishSubject<String>()
    
}

// MARK: - BasePresenterProtocol
extension BaseViewModel: BaseViewModelProtocol {
    
    var toastSuccess: Observable<String> {
        return toastSuccessSubject.asObservable()
    }
    var toastError: Observable<String> {
        return toastErrorSubject.asObservable()
    }
}


