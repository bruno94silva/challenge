//
//  String.swift
//  Challenge
//
//  Created by Bruno dos Santos Silva on 05/08/21.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isTwoWordsOrMore() -> Bool {
        let twoWordsOrMoreRegEx = "^[a-zA-Z-]+ ?.* [a-zA-Z-]+$"
        let twoWordsOrMoreRegExPred = NSPredicate(format: "SELF MATCHES %@", twoWordsOrMoreRegEx)
        return twoWordsOrMoreRegExPred.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let passwordRegExPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordRegExPred.evaluate(with: self)
    }
}
