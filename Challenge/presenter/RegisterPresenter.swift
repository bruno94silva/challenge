//
//  RegisterPresenter.swift
//  Challenge
//
//  Created by Bruno dos Santos Silva on 04/08/21.
//

import Foundation

class RegisterPresenter: NSObject {
 
    let registerRequest = RegisterRequest()
    let mobileSessionDAO = MobileSessionDAOImpl()
    var myViewControllerDelegate: MyViewControllerDelegate!
    var activityIndicatorHelper: ActivityIndicatorHelper?
    
    init(myViewControllerDelegate: MyViewControllerDelegate, activityIndicatorHelper: ActivityIndicatorHelper) {
        self.myViewControllerDelegate = myViewControllerDelegate
        self.activityIndicatorHelper = activityIndicatorHelper
    }
    
    func register(fullName: String?, email: String?, cpf: String?, phoneNumber: String?, password: String?, confirmPassword: String?, emailNewsletter: Bool) {
        
        if fullName != nil && !fullName!.isEmpty {
            
            let isTwoWordsOrMore = fullName!.isTwoWordsOrMore()
            
            if !isTwoWordsOrMore {
                self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "Nome e sobrenome são necessários.")
            } else {
                if email != nil && !email!.isEmpty {
                    
                    let isValidEmail = email!.isValidEmail()
                    
                    if !isValidEmail {
                        self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "E-mail inválido.")
                    } else {
                        if cpf != nil && !cpf!.isEmpty {
                            
                            if cpf!.count < 11 {
                                self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "CPF inválido.")
                            } else {
                                if phoneNumber != nil && !phoneNumber!.isEmpty {

                                    if phoneNumber!.count < 11 {
                                        self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "O número de telefone deve conter 11 dígitos, contando com o DDD.")
                                    } else {
                                        if password != nil && !password!.isEmpty {
                                            
                                            if password!.count < 8 {
                                                self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "A senha deve possuir pelo menos oito caracteres, ao menos uma letra maiúscula e um número.")
                                            } else {
                                                
                                                let isValidPassword = password!.isValidPassword()
                                                
                                                if !isValidPassword {
                                                    self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "A senha deve possuir pelo menos oito caracteres, ao menos uma letra maiúscula e um número.")
                                                } else {
                                                    if confirmPassword != nil && !confirmPassword!.isEmpty {
                                                        
                                                        if password!.elementsEqual(confirmPassword!) {
                                                            self.activityIndicatorHelper!.start()
                                                            
                                                            var parameters: [String : Any] = [:]
                                                            parameters["name"] = fullName!
                                                            parameters["email"] = email!
                                                            parameters["phoneNumber"] = phoneNumber!
                                                            parameters["password"] = password!
                                                            parameters["emailUpdatesAllowed"] = emailNewsletter
                                                            parameters["cpf"] = cpf!
                                                            
                                                            registerRequest.registerUser(parameters: parameters) { statusCode in
                                                                
                                                                self.activityIndicatorHelper!.stop()
                                                                
                                                                if statusCode == 200 {
                                                                    do {
                                                                        let mobileSession = try self.mobileSessionDAO.getMobileSession()
                                                                        
                                                                        self.myViewControllerDelegate.success(mobileSession: mobileSession)
                                                                    } catch {
                                                                        print(error)
                                                                    }
                                                                } else {
                                                                    self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "Problema ao tentar fazer requisição. Contate o administrado.")
                                                                }
                                                            }
                                                            
                                                        } else {
                                                            self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "A confirmação de senha deve ser igual à senha inserida.")
                                                        }
 
                                                    } else {
                                                        self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "A confirmação de senha deve ser igual à senha inserida.")
                                                    }
                                                }
                                            }
                                        } else {
                                            self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "Informe uma senha.")
                                        }
                                    }
                                } else {
                                    self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "Informe o número do seu celular.")
                                }
                            }
                        } else {
                            self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "Informe seu CPF.")
                        }
                    }
                } else {
                    self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "Informe um e-mail.")
                }
            }
        } else {
            self.myViewControllerDelegate.showMessageAlert(title: "Atenção", message: "Informe um nome.")
        }
    }
}
