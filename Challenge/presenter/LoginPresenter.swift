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
            if !email!.isValidEmail() {
                self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "Informe um e-mail válido.")
            } else {
                if password != nil && !password!.isEmpty {
                    
                    self.activityIndicatorHelper!.start()
                    
                    var parameters: [String : String] = [:]
                    parameters["email"] = email!
                    parameters["password"] = password!
                                    
                    loginRequest.login(parameters: parameters) { retorno in

                        self.activityIndicatorHelper!.stop()

                        let retornoArray = retorno.split(separator: "|")
                        
                        if retornoArray[0] == "200" {
                            do {
                                let mobileSession = try self.mobileSessionDAO.getMobileSession(token: String(retornoArray[1]))
                                
                                self.myViewControllerDelegate.success(mobileSession: mobileSession)
                            } catch {
                                print(error)
                                self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "Ocorreu um erro ao efetuar o login. Verifique sua conexão e tente novamente.")
                            }
                        } else {
                            self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "Ocorreu um erro ao efetuar o login. Verifique sua conexão e tente novamente.")
                        }
                    }
                } else {
                    self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "Informe sua senha.")
                }
            }
        } else {
            self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "Informe seu e-mail.")
        }
    }
    
}
