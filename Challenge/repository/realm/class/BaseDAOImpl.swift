//
//  BaseDAOImpl.swift
//  Challenge
//
//  Created by Bruno dos Santos Silva on 05/08/21.
//

import Foundation
import RealmSwift

class BaseDAOImpl: BaseDAO {
    
    func save(realmObject: Object) throws {
        do {
            let realm = try RealmHelper().getRealm()
            
            try! realm.write {
                realm.add(realmObject)
            }
            
        } catch {
            print(error)
            throw error
        }
    }
}
