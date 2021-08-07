//
//  MobileSession.swift
//  Challenge
//
//  Created by Bruno dos Santos Silva on 04/08/21.
//

import Foundation
import RealmSwift

class MobileSession: Object, Codable {
    
    @objc dynamic var token: String?
    @objc dynamic var user: User?
    
    func primaryKey() -> String? {
        return "token"
    }
}
