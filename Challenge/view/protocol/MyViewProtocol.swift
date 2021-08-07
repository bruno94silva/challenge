//
//  LoginPresenterDelegate.swift
//  Challenge
//
//  Created by Bruno dos Santos Silva on 04/08/21.
//

import Foundation

protocol MyViewProtocol {
    
    func showMessageAlert(title: String, message: String)
    
    func success(mobileSession: MobileSession)
    
}
