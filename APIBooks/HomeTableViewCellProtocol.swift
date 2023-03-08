//
//  TableViewCellProtocol.swift
//  APIBooks
//
//  Created by raul.santos on 15/02/23.
//

import Foundation


protocol NotificationCenterTableViewCellProtocol: TableViewCellProtocol {
    var delegateCell: Any? {get set}
}
