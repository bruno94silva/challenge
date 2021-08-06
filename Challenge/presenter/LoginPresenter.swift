//
//  LoginPresenter.swift
//  Challenge
//
//  Created by Bruno dos Santos Silva on 04/08/21.
//

import Foundation

class LoginPresenter: NSObject {
    
    let loginRequest = LoginRequest()
    let mobileSessionDAO = MobileSessionDAOImpl()
    var myViewControllerDelegate: MyViewControllerDelegate!
    var activityIndicatorHelper: ActivityIndicatorHelper?
    
    init(myViewControllerDelegate: MyViewControllerDelegate, activityIndicatorHelper: ActivityIndicatorHelper) {
        self.myViewControllerDelegate = myViewControllerDelegate
        self.activityIndicatorHelper = activityIndicatorHelper
    }
    
    func login(email: String?, password: String?) {
        
        if email != nil && !email!.isEmpty {

            let isValidEmail = email!.isValidEmail()

            if !isValidEmail {
                self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "Informe um e-mail válido.")
            } else {
                if password != nil && !password!.isEmpty {
                    
                    self.activityIndicatorHelper!.start()
                    
                    var parameters: [String : String] = [:]
                    parameters["email"] = email!
                    parameters["password"] = password!
                                    
                    loginRequest.login(parameters: parameters) { statusCode in

                        self.activityIndicatorHelper!.stop()

                        if statusCode == 200 {

                            do {
                                let mobileSession = try self.mobileSessionDAO.getMobileSession()
                                
                                self.myViewControllerDelegate.success(mobileSession: mobileSession)
                            } catch {
                                print(error)
                            }
                            
                        } else if statusCode == 404 {
                            self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "Usuário e/ou senha inválidos.")
                            
                        } else if statusCode == 422 {
                            self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "Usuário e/ou senha inválidos.")
                            
                        } else if statusCode == 999 {
                            self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "Problema ao tentar fazer requisição. Contate o administrador.")
                        }
                    }
                } else {
                    self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "Informe a senha.")
                }
            }
        } else {
            self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "Informe o e-mail.")
        }
    }
    
}
