//
//  RegisterPresenter.swift
//  Challenge
//
//  Created by Bruno dos Santos Silva on 04/08/21.
//

import Foundation

class RegisterPresenter: RegisterPresenterProtocol {
 
    let registerRequest = RegisterRequest()
    let mobileSessionDAO = MobileSessionDAOImpl()
    var view: MyViewProtocol?
    var activityIndicatorHelper: ActivityIndicatorHelper?
    var statusCodeRegister: String = ""
    
    init() {
        
    }
    
    init(view: MyViewProtocol, activityIndicatorHelper: ActivityIndicatorHelper) {
        self.view = view
        self.activityIndicatorHelper = activityIndicatorHelper
    }
    
    func register(fullName: String, email: String, cpf: String, phoneNumber: String, password: String, confirmPassword: String, emailUpdate: Bool) {
        
        if !fullName.isEmpty {
            if !fullName.isTwoWordsOrMore() {
                self.view?.showMessageAlert(title: "Atenção", message: "Nome e sobrenome são necessários.")
            } else {
                
                if !email.isEmpty {
                    if !email.isValidEmail() {
                        self.view?.showMessageAlert(title: "Atenção", message: "E-mail inválido.")
                    } else {
                        
                        if !cpf.isEmpty {
                            if cpf.count < 11 {
                                self.view?.showMessageAlert(title: "Atenção", message: "CPF inválido.")
                            } else {
                                
                                if !phoneNumber.isEmpty {
                                    if phoneNumber.count < 11 {
                                        self.view?.showMessageAlert(title: "Atenção", message: "O número de telefone deve conter 11 dígitos, contando com o DDD.")
                                    } else {
                                        
                                        if !password.isEmpty {
                                            if !password.isValidPassword() {
                                                self.view?.showMessageAlert(title: "Atenção", message: "A senha deve possuir pelo menos oito caracteres, ao menos uma letra maiúscula e um número.")
                                            } else {
                                                
                                                if !confirmPassword.isEmpty {
                                                    if confirmPassword.elementsEqual(password){
                                                        self.activityIndicatorHelper?.start()
                                                        
                                                        var parameters: [String : Any] = [:]
                                                        parameters["name"] = fullName
                                                        parameters["email"] = email
                                                        parameters["phoneNumber"] = phoneNumber
                                                        parameters["password"] = password
                                                        parameters["emailUpdatesAllowed"] = emailUpdate
                                                        parameters["cpf"] = cpf
                                                        
                                                        registerRequest.registerUser(parameters: parameters) { statusCode in
                                                            
                                                            self.activityIndicatorHelper?.stop()
                                                            
                                                            self.statusCodeRegister = String(statusCode)
                                                            
                                                            if statusCode == 200 {
                                                                self.view?.showMessageAlert(title: "Sucesso", message: "Usuário cadastrado com sucesso!")
                                                            } else {
                                                                self.view?.showMessageAlert(title: "Atenção", message: "Ocorreu um erro ao efetuar o registro. Verifique sua conexão e tente novamente.")
                                                            }
                                                        }
                                                    } else {
                                                        self.view?.showMessageAlert(title: "Atenção", message: "A confirmação de senha deve ser igual à senha inserida.")
                                                    }
                                                } else {
                                                    self.view?.showMessageAlert(title: "Atenção", message: "Confirme sua senha informando ela novamente.")
                                                }
                                            }
                                        } else {
                                            self.view?.showMessageAlert(title: "Atenção", message: "Informe uma senha.")
                                        }
                                    }
                                } else {
                                    self.view?.showMessageAlert(title: "Atenção", message: "Informe o número do seu telefone celular.")
                                }
                            }
                        } else {
                            self.view?.showMessageAlert(title: "Atenção", message: "Informe seu CPF.")
                        }
                    }
                } else {
                    self.view?.showMessageAlert(title: "Atenção", message: "Informe seu e-mail.")
                }
            }
        } else {
            self.view?.showMessageAlert(title: "Atenção", message: "Informe seu nome completo.")
        }
    }
}
