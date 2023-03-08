//
//  HomeController.swift
//  APIBooks
//
//  Created by raul.santos on 08/02/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeController : BaseViewController <HomeView>, UIScrollViewDelegate  {
 
    
    var booksViewModel: BookListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        self.customView.tableView.register(BookCell.self, forCellReuseIdentifier: BookCell.identifier)
        
        
        populateCell()
    }
    
    
    private func populateCell() {
        
        let resource = Resource<BooksResponse>(url: URL(string:"https://www.googleapis.com/books/v1/volumes?q=(query)&maxResults=20&startIndex=0")!)
        
        disposeBag = DisposeBag()
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: { books in
            

                let books = books.items
                self.booksViewModel =  BookListViewModel(books)

                DispatchQueue.main.async {
                   self.customView.tableView.reloadData()
                }
                
            }).disposed(by: disposeBag)
    }
    
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.booksViewModel == nil ? 0 : booksViewModel.bookVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCardCell", for: indexPath) as! BookCell

        
        let booksVm = self.booksViewModel.booksAt(indexPath.row)
        
        booksVm.title.asDriver(onErrorJustReturn: "")
            .drive(cell.bookNameLb.rx.text)
            .disposed(by: disposeBag)
        
        booksVm.publisher.asDriver(onErrorJustReturn: "")
            .drive(cell.authorBookLb.rx.text)
            .disposed(by: disposeBag)
    
        booksVm.thumbnail.asDriver(onErrorJustReturn: "")
            .drive(cell.linkImageLabel.rx.text)
            .disposed(by: disposeBag)
        
        cell.capaDolivro.load(urlString: cell.linkImageLabel.text ?? "")
        
        return cell
    }
    
}


extension UIImageView {

    func load(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    
}
