//
//  RegisterPresenterProtocol.swift
//  Challenge
//
//  Created by Bruno dos Santos Silva on 07/08/21.
//

import Foundation

protocol RegisterPresenterProtocol {
    
    func register(fullName: String, email: String, cpf: String, phoneNumber: String, password: String, confirmPassword: String, emailUpdate: Bool)
}
