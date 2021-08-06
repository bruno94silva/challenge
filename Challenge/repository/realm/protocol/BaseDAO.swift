//
//  BaseDAO.swift
//  Challenge
//
//  Created by Bruno dos Santos Silva on 05/08/21.
//

import Foundation
import RealmSwift

protocol BaseDAO {
    func save(realmObject: Object) throws
}
