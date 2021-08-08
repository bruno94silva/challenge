//
//  ViewController.swift
//  Challenge
//
//  Created by Bruno dos Santos Silva on 04/08/21.
//

import UIKit
import RealmSwift

class LoginViewController: UIViewController, UITextFieldDelegate, MyViewProtocol {

    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    var loginPresenter: LoginPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginPresenter = LoginPresenter(view: self, activityIndicatorHelper: ActivityIndicatorHelper(view: view))
        
        txtFieldEmail.delegate = self
        txtFieldPassword.delegate = self
        
        btnLogin.layer.cornerRadius = 10
              
        let viewFrameWidth = view.frame.width
        
        let bottomLineEmail = CALayer()
        bottomLineEmail.frame = CGRect(x: 0, y: txtFieldEmail.frame.height - 2, width: viewFrameWidth - 76, height: 2)
        bottomLineEmail.backgroundColor = UIColor.white.cgColor
    
        let bottomLineSenha = CALayer()
        bottomLineSenha.frame = CGRect(x: 0, y: txtFieldPassword.frame.height - 2, width: viewFrameWidth - 76, height: 2)
        bottomLineSenha.backgroundColor = UIColor.white.cgColor
        
        txtFieldEmail.borderStyle = UITextField.BorderStyle.none
        txtFieldEmail.layer.addSublayer(bottomLineEmail)
                
        txtFieldPassword.borderStyle = UITextField.BorderStyle.none
        txtFieldPassword.layer.addSublayer(bottomLineSenha)
    }
    
    @IBAction func login(_ sender: Any) {
        
        txtFieldEmail.isEnabled = false
        txtFieldPassword.isEnabled = false
        btnLogin.isEnabled = false
        
        if ConnectivityHelper.isConnectedToInternet() {
            self.loginPresenter.login(email: txtFieldEmail.text!, password: txtFieldPassword.text!)
        } else {
            showMessageAlert(title: "Atenção", message: "Verifique sua conexão com a internet e tente novamente.")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func showMessageAlert(title: String, message: String) {
        txtFieldEmail.isEnabled = true
        txtFieldPassword.isEnabled = true
        btnLogin.isEnabled = true
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func success(mobileSession: MobileSession) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeView = storyboard.instantiateViewController(identifier: "homeViewController") as! HomeViewController
        homeView.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        homeView.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        homeView.mobileSession = mobileSession
        
        present(homeView, animated: true, completion: nil)
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFieldEmail {
            txtFieldPassword.becomeFirstResponder()
        } else if textField == txtFieldPassword {
            txtFieldPassword.resignFirstResponder()
        }
        
        return true
    }
}

