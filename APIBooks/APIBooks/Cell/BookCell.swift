//
//  BookCell.swift
//  APIBooks
//
//  Created by raul.santos on 08/02/23.
//

import Foundation
import UIKit
import SnapKit

class BookCell: UITableViewCell {
    
    
    static let identifier = "BookCardCell"
    
    
    lazy var cardView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.17
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        return view
    }()
    
    lazy var capaDolivro : UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .blue
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        
        return view
    }()


    lazy var bookNameLb : UILabel = {
        let lb = UILabel()
        lb.text = "Harry potter"
        lb.numberOfLines = 0
        lb.font = lb.font.withSize(14)
        
        return lb
    }()
    
    
    lazy var authorBookLb : UILabel = {
        let lb = UILabel()
        lb.text = "Jk Holling"
        lb.numberOfLines = 0
        lb.font = lb.font.withSize(12)
        lb.textColor = .gray
        
        return lb
    }()
    
    lazy var linkImageLabel : UILabel = {
        let lb = UILabel()
        lb.text = "Jk Holling"
        lb.numberOfLines = 0
        lb.font = lb.font.withSize(12)
        lb.textColor = .gray
        
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.addSubview(self.cardView)
        cardView.addSubview(capaDolivro)
        cardView.addSubview(bookNameLb)
        cardView.addSubview(authorBookLb)

        self.cardView.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(130)
        }

        self.capaDolivro.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalToSuperview()
            make.width.equalTo(90)
            make.height.equalTo(110)
            make.leading.equalToSuperview().offset(20)
        }
        
        self.bookNameLb.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(cardView.safeAreaLayoutGuide.snp.top).offset(15)
            make.leading.equalTo(capaDolivro.snp.trailing).offset(12)
            make.trailing.equalTo(-20)
        }
        
        self.authorBookLb.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(bookNameLb.snp.bottom).offset(16)
            make.leading.equalTo(capaDolivro.snp.trailing).offset(12)
            make.trailing.equalTo(-20)
        }
        
    }
    
}
