//
//  MobileSessionDAOImpl.swift
//  Challenge
//
//  Created by Bruno dos Santos Silva on 05/08/21.
//

import Foundation
import RealmSwift

class MobileSessionDAOImpl: BaseDAOImpl, MobileSessionDAO {
 
    func getMobileSession() throws -> MobileSession {
        var mobileSession = MobileSession()
        
        do {
            let realm = try RealmHelper().getRealm()
            
            let objects = realm.objects(MobileSession.self)
            
            if !objects.isEmpty {
                mobileSession = objects[0]
            }
            
        } catch {
            print(error)
            throw error
        }
        
        return mobileSession
    }
}
