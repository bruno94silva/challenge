//
//  LoginPresenter.swift
//  Challenge
//
//  Created by Bruno dos Santos Silva on 04/08/21.
//

import Foundation

class LoginPresenter: LoginPresenterProtocol {
    
    let loginRequest = LoginRequest()
    let mobileSessionDAO = MobileSessionDAOImpl()
    var view: MyViewProtocol?
    var activityIndicatorHelper: ActivityIndicatorHelper?
    var statusCodeLogin: String = ""
    
    init() {
        
    }
    
    init(view: MyViewProtocol, activityIndicatorHelper: ActivityIndicatorHelper) {
        self.view = view
        self.activityIndicatorHelper = activityIndicatorHelper
    }
    
    func login(email: String, password: String) {
        if !email.isEmpty {
            if !email.isValidEmail() {
                self.view?.showMessageAlert(title: "Atenção", message: "Informe um e-mail válido.")                
            } else {
                if !password.isEmpty {
                    self.activityIndicatorHelper?.start()
                    
                    var parameters: [String : String] = [:]
                    parameters["email"] = email
                    parameters["password"] = password
                                    
                    loginRequest.login(parameters: parameters) { retorno in

                        self.activityIndicatorHelper?.stop()

                        let retornoArray = retorno.split(separator: "|")
                        
                        self.statusCodeLogin = String(retornoArray[0])
                        
                        if retornoArray[0] == "200" {
                            do {
                                let mobileSession = try self.mobileSessionDAO.getMobileSession(token: String(retornoArray[1]))
                                
                                self.view?.success(mobileSession: mobileSession)
                            } catch {
                                print(error)
                                self.view?.showMessageAlert(title: "Atenção", message: "Ocorreu um erro ao efetuar o login. Verifique sua conexão e tente novamente.")
                            }
                        } else {
                            self.view?.showMessageAlert(title: "Atenção", message: "Ocorreu um erro ao efetuar o login. Verifique sua conexão e tente novamente.")
                        }
                    }
                } else {
                    self.view?.showMessageAlert(title: "Atenção", message: "Informe sua senha.")
                }
            }
        } else {
            self.view?.showMessageAlert(title: "Atenção", message: "Informe seu e-mail.")
        }
    }
}
