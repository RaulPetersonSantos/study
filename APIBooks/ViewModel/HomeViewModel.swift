//
//  HomeViewModel.swift
//  APIBooks
//
//  Created by raul.santos on 08/02/23.
//

import UIKit
import RxCocoa
import RxSwift


class HomeViewModel: BaseViewModel {

    
}

struct BookListViewModel {
    let bookVM: [BookViewModel]
    
}

extension BookListViewModel {
   
    init(_ books: [Item]) {
        self.bookVM = books.compactMap(BookViewModel.init)
    }
    
}

extension BookListViewModel {
    
    func booksAt(_ index: Int) -> BookViewModel {
        return self.bookVM[index]
    }
}

struct BookViewModel {
    
    let book: Item
    
    init(book: Item) {
        self.book = book
    }
 
}

extension BookViewModel {
    
    var title: Observable<String> {
        return Observable<String>.just(book.volumeInfo.title)
    }
    
    var publisher: Observable<String> {
        return Observable<String>.just(book.volumeInfo.publisher ?? "")
    }
    
    var thumbnail: Observable<String> {
        return Observable<String>.just(book.volumeInfo.imageLinks.thumbnail)
    }
    
}


struct Resource <T: Decodable> {
    
    let url: URL
}


extension URLRequest {
    
    static func load<T>(resource: Resource<T>) -> Observable<T> {
        
        return Observable.just(resource.url)
            .flatMap{ url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
                
            }.map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
        
    }
    
}
