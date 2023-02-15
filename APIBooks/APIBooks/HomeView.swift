//
//  HomeView.swift
//  APIBooks
//
//  Created by raul.santos on 08/02/23.
//

import Foundation
import UIKit
import SnapKit

class HomeView: BaseView {
    
    lazy var headerView: UIImageView = {
        let v = UIImageView()
        v.backgroundColor = .red
        return v
    }()
    
    lazy var profileName: UILabel = {
        let lb = UILabel()
        lb.text = "Books API"
        lb.numberOfLines = 0
        lb.textColor = .white
        lb.font = lb.font.withSize(24)
        lb.font = UIFont.boldSystemFont(ofSize: 24)
        
        return lb
    }()
    
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(BookCell.self, forCellReuseIdentifier: BookCell.identifier)
        tv.bounces = false
        tv.allowsSelection = false
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 48, right: 0)
        tv.backgroundColor = .white
        return tv
    }()
    
    lazy var borderTabView: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        v.layer.shadowColor = UIColor.gray.cgColor
        v.layer.shadowOpacity = 0.8
        v.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        return v
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        self.setup()
        self.setupTableview()
      
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup() {
        backgroundColor = .white
        addSubview(headerView)
        headerView.addSubview(profileName)

        self.profileName.snp.makeConstraints{ (make) -> Void in
            make.centerY.centerX.equalToSuperview()
        }
        
        self.headerView.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(90)
            make.top.left.right.equalToSuperview()
        }
        

        
    }
    
    private func setupTableview() {
        addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor,constant: 0),
        ])
        
    }
    
}
