//
//  User.swift
//  Challenge
//
//  Created by Bruno dos Santos Silva on 04/08/21.
//

import Foundation
import RealmSwift

class User: Object, Codable {
    
    let rowId = RealmOptional<Int>()
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var email: String?
    @objc dynamic var password: String?
    @objc dynamic var cpf: String?
    @objc dynamic var phoneNumber: String?
    
    func primaryKey() -> String? {
        return "rowId"
    }
}
