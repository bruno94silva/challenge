//
//  MobileSessionDAO.swift
//  Challenge
//
//  Created by Bruno dos Santos Silva on 05/08/21.
//

import Foundation

protocol MobileSessionDAO {
    func getMobileSession(token: String) throws -> MobileSession
}
