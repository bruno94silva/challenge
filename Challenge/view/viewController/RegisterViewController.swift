//
//  RegisterViewController.swift
//  Challenge
//
//  Created by Bruno dos Santos Silva on 04/08/21.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate, MyViewProtocol {

    @IBOutlet weak var txtFieldFullName: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldCPF: UITextField!
    @IBOutlet weak var txtFieldPhoneNumber: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var txtFieldPasswordConfirm: UITextField!
    @IBOutlet weak var switchEmailNewsletter: UISwitch!
    @IBOutlet weak var btnRegister: UIButton!
    
    var registerPresenter: RegisterPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerPresenter = RegisterPresenter(view: self, activityIndicatorHelper: ActivityIndicatorHelper(view: view))
        
        txtFieldFullName.delegate = self
        txtFieldEmail.delegate = self
        txtFieldCPF.delegate = self
        txtFieldPhoneNumber.delegate = self
        txtFieldPassword.delegate = self
        txtFieldPasswordConfirm.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        btnRegister.layer.cornerRadius = 10

        let bottomLineFullName = CALayer()
        bottomLineFullName.frame = CGRect(x: 0, y: txtFieldFullName.frame.height - 2, width: txtFieldFullName.frame.width, height: 2)
        bottomLineFullName.backgroundColor = UIColor.white.cgColor
        
        let bottomLineEmail = CALayer()
        bottomLineEmail.frame = CGRect(x: 0, y: txtFieldEmail.frame.height - 2, width: txtFieldEmail.frame.width, height: 2)
        bottomLineEmail.backgroundColor = UIColor.white.cgColor
        
        let bottomLineCPF = CALayer()
        bottomLineCPF.frame = CGRect(x: 0, y: txtFieldCPF.frame.height - 2, width: txtFieldCPF.frame.width, height: 2)
        bottomLineCPF.backgroundColor = UIColor.white.cgColor
        
        let bottomLinePhoneNumber = CALayer()
        bottomLinePhoneNumber.frame = CGRect(x: 0, y: txtFieldPhoneNumber.frame.height - 2, width: txtFieldPhoneNumber.frame.width, height: 2)
        bottomLinePhoneNumber.backgroundColor = UIColor.white.cgColor
        
        let bottomLinePassword = CALayer()
        bottomLinePassword.frame = CGRect(x: 0, y: txtFieldPassword.frame.height - 2, width: txtFieldPassword.frame.width, height: 2)
        bottomLinePassword.backgroundColor = UIColor.white.cgColor
        
        let bottomLinePasswordConfirm = CALayer()
        bottomLinePasswordConfirm.frame = CGRect(x: 0, y: txtFieldPasswordConfirm.frame.height - 2, width: txtFieldPasswordConfirm.frame.width, height: 2)
        bottomLinePasswordConfirm.backgroundColor = UIColor.white.cgColor
        
        txtFieldFullName.borderStyle = UITextField.BorderStyle.none
        txtFieldFullName.layer.addSublayer(bottomLineFullName)
        
        txtFieldEmail.borderStyle = UITextField.BorderStyle.none
        txtFieldEmail.layer.addSublayer(bottomLineEmail)
        
        txtFieldCPF.borderStyle = UITextField.BorderStyle.none
        txtFieldCPF.layer.addSublayer(bottomLineCPF)
        
        txtFieldPhoneNumber.borderStyle = UITextField.BorderStyle.none
        txtFieldPhoneNumber.layer.addSublayer(bottomLinePhoneNumber)
        
        txtFieldPassword.borderStyle = UITextField.BorderStyle.none
        txtFieldPassword.layer.addSublayer(bottomLinePassword)
        
        txtFieldPasswordConfirm.borderStyle = UITextField.BorderStyle.none
        txtFieldPasswordConfirm.layer.addSublayer(bottomLinePasswordConfirm)
    }
    
    @IBAction func register(_ sender: Any) {
        
        var fullName: String = ""
        var email: String = ""
        var cpf: String = ""
        var phoneNumber: String = ""
        var password: String = ""
        var confirmPassword: String = ""

        if let fullNameApoio = txtFieldFullName.text {
            fullName = fullNameApoio
        }
        
        if let emailApoio = txtFieldEmail.text {
            email = emailApoio
        }
        
        if let cpfApoio = txtFieldCPF.text {
            cpf = cpfApoio
        }
        
        if let confirmPasswordApoio = txtFieldPasswordConfirm.text {
            confirmPassword = confirmPasswordApoio
        }
        
        if let phoneNumberApoio = txtFieldPhoneNumber.text {
            let newPhoneNumber1 = phoneNumberApoio.replacingOccurrences(of: "(", with: "")
            let newPhoneNumber2 = newPhoneNumber1.replacingOccurrences(of: ")", with: "")
            let newPhoneNumber3 = newPhoneNumber2.replacingOccurrences(of: "-", with: "")
            let newPhoneNumber4 = newPhoneNumber3.replacingOccurrences(of: " ", with: "")
            
            phoneNumber = newPhoneNumber4
        }

        if let passwordApoio = txtFieldPassword.text {
            password = passwordApoio
        }
        
        txtFieldFullName.isEnabled = false
        txtFieldEmail.isEnabled = false
        txtFieldCPF.isEnabled = false
        txtFieldPhoneNumber.isEnabled = false
        txtFieldPassword.isEnabled = false
        txtFieldPasswordConfirm.isEnabled = false
        btnRegister.isEnabled = false
        
        if ConnectivityHelper.isConnectedToInternet() {
            self.registerPresenter.register(fullName: fullName, email: email, cpf: cpf, phoneNumber: phoneNumber, password: password, confirmPassword: confirmPassword, emailUpdate: switchEmailNewsletter.isOn)
        } else {
            showMessageAlert(title: "Atenção", message: "Verifique sua conexão com a internet e tente novamente.")
        }
    }
    
    func showMessageAlert(title: String, message: String) {
        
        txtFieldFullName.isEnabled = true
        txtFieldEmail.isEnabled = true
        txtFieldCPF.isEnabled = true
        txtFieldPhoneNumber.isEnabled = true
        txtFieldPassword.isEnabled = true
        txtFieldPasswordConfirm.isEnabled = true
        btnRegister.isEnabled = true
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txtFieldCPF {
            if let text = textField.text {
                if text.count < 11 {
                    return true
                } else {
                    textField.deleteBackward()
                    return false
                }
            } else {
                return true
            }
        } else if textField == txtFieldPhoneNumber {
            if let text = textField.text {
                if text.count < 15 {
                    return true
                } else {
                    textField.deleteBackward()
                    return false
                }
            } else {
                return true
            }
        }
            
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFieldFullName {
            txtFieldEmail.becomeFirstResponder()
        } else if textField == txtFieldEmail {
            txtFieldCPF.becomeFirstResponder()
        } else if textField == txtFieldPassword {
            txtFieldPasswordConfirm.becomeFirstResponder()
        } else if textField == txtFieldPasswordConfirm {
            txtFieldPasswordConfirm.resignFirstResponder()
        }
        
        return true
    }
}
