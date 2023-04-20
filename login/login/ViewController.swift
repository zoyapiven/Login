//
//  ViewController.swift
//  login
//
//  Created by Miroslav Deryuga on 08.04.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var envelopImageView: UIImageView!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var emailLineView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLineView: UIView!
    @IBOutlet weak var lockImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var dontHaveAccountLabel: UILabel!
    @IBOutlet weak var SignUpButton: UIButton!
    
    // MARK: - Properties
    private var email = ""
    private var password = ""
    
    private let mockPassword = "12345"
    private let mockEmail = "123@.45"
   
    // MARK: - Life Cycle (viewDidLoad)
    override func viewDidLoad() {
        super.viewDidLoad()
        setShadow()
        emailTextfield.delegate = self
        passwordTextField.delegate = self
        emailTextfield.becomeFirstResponder()
    }
    
    // MARK: - IBActions
   
    @IBAction func loginButtonAction(_ sender: UIButton) {
        emailTextfield.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        if email.isEmpty {
            makeErrorField(textField: emailTextfield)
        }
        if password.isEmpty {
            makeErrorField(textField: passwordTextField)
        }
        if email == mockEmail,
           password == mockPassword {
        performSegue(withIdentifier: "GoToHomePage", sender: sender)
    } else {
        let alert = UIAlertController(title: "Error".localized,
            message: "Wrong Password or E-mail".localized,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK".localized,
                                   style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
    @IBAction func signUpAction(_ sender: UIButton) {
        print("Sign Up")
    }
    
    // MARK: - Private Methods
    private func setShadow() {
        loginButton.layer.shadowColor = UIColor.link.cgColor
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        loginButton.layer.shadowOpacity = 0.1
        
        loginButton.isUserInteractionEnabled = false
        loginButton.backgroundColor = .lightGray
    }
}

extension ViewController: UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
      guard  let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
        !text.isEmpty else { return }
        switch textField {
        case emailTextfield:
            let isValidEmail = check(email: text)
            loginButton.isUserInteractionEnabled = isValidEmail
            loginButton.backgroundColor = isValidEmail ? .link : .lightGray
            
            if isValidEmail {
                email = text
                envelopImageView.tintColor = .link
                emailLineView.backgroundColor = .link
            } else {
                email = ""
                makeErrorField(textField: textField)
            }
        case passwordTextField:
            let isValidPassword = check(password: text)
            loginButton.isUserInteractionEnabled = isValidPassword
            loginButton.backgroundColor = isValidPassword ? .link : .lightGray
            
            if isValidPassword {
                password = text
                lockImageView.tintColor = .link
                passwordLineView.backgroundColor = .link
            } else {
                password = ""
                
                makeErrorField(textField: textField)
            }
        default:
            print("Unknown Text Field")
            
        }
    }
    
    private func check(email: String) -> Bool {
        return email.contains("@") && email.contains(".")
        
    }
    
    private func check(password: String) -> Bool {
        return password.count >= 4
    }
    
    private func makeErrorField(textField: UITextField) {
        switch textField {
        case emailTextfield:
            envelopImageView.tintColor = .lightGray
            emailLineView.backgroundColor = .lightGray
        case passwordTextField:
            lockImageView.tintColor = .lightGray
            passwordLineView.backgroundColor = .lightGray
        default:
            print("Unknown Text Field")
        }
        
    }
}
