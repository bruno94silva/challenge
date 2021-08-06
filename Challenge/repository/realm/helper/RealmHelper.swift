//
//  RealmHelper.swift
//  Challenge
//
//  Created by Bruno dos Santos Silva on 05/08/21.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    func getRealm() throws -> Realm {
        do {
            return try Realm()
        } catch {
            print(error)
            throw error
        }
    }
}
