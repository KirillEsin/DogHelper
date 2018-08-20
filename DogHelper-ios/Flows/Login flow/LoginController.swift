//
//  LoginController.swift
//  FlowTestController
//
//  Created by Кирилл on 16.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
import UIKit
//import Firebase
import Localize_Swift

import Spring

class LoginController: UIViewController, LoginView {
    
    var onCompleteAuth: (() -> Void)?
    var onSignUpButtonTap: (() -> Void)?
    var onDismissTap: (() -> Void)?
    
    var viewModel: LoginViewModelProtocol!
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In".localized(), for: .normal)
        button.backgroundColor = ColorPalette.mainColor
        
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        return button
    }()
    
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("signUpButton", for: .normal)
        
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: "Don't have account yet? ".localized(), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        attributedString.append(NSAttributedString(string: "Sign un".localized(), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: ColorPalette.mainColor]))
        
        
        button.setAttributedTitle(attributedString, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        return button
    }()
    
    let forgotButton: SpringButton = {
        let button = SpringButton(type: .system)
        button.setTitle("Forgot password?".localized(), for: .normal)
        button.setTitleColor(ColorPalette.mainColor, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        
        //button.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        return button
    }()
    
    let emailTextField: SpringTextField = {
        let tf = SpringTextField()
        tf.placeholder = "Email".localized()
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordTextField: SpringTextField = {
        let tf = SpringTextField()
        tf.placeholder = "Password".localized()
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelError: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()
    
    @objc func loginButtonClicked() {
        
        emailTextField.text = "qwe@qw.ua"
        passwordTextField.text = "12345678"
        
        viewModel.validate(email: emailTextField.text, password: passwordTextField.text)
        hideKeyboard()
    }
    
    @objc func signUpButtonClicked() {
        onSignUpButtonTap?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        observeKeyboardAppearance()
        addGestureForHideKeyBoard()
        setupBarButtonItems()
        setupTextFields()
        
        viewModel.didValidationCallback = { [weak self] fields in
            self?.errorValidation(fields)
        }
        
        viewModel.didSignInCallback = { [weak self] in
            self?.onCompleteAuth?()
        }
        
        viewModel.errorCallback = {[weak self] error in
            self?.showError(error)
            self?.clearFields()
        }
    }
    
    private func errorValidation(_ fields: [AuthorizationErrorField]) {
        fields.forEach {
            switch $0 {
            case .password:
                passwordTextField.animation = "swing"
                passwordTextField.curve = "linear"
                passwordTextField.duration = 0.5
                passwordTextField.animate()
            case .email:
                emailTextField.animation = "swing"
                emailTextField.curve = "linear"
                emailTextField.duration = 0.5
                emailTextField.animate()
            case .username:
                break
            }
        }
    }
    
    private func clearFields() {
        emailTextField.text = nil
        passwordTextField.text = nil
    }
    
    private func showError(_ error: String) {
        forgotButton.setTitle(error, for: .normal)
        forgotButton.setTitleColor(.red, for: .normal)
        forgotButton.isUserInteractionEnabled = false
        forgotButton.animation = "shake"
        forgotButton.curve = "spring"
        forgotButton.animate()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.forgotButton.animateNext { [weak self] in
                self?.forgotButton.isUserInteractionEnabled = true
                self?.forgotButton.setTitle("Forgot password?".localized(), for: .normal)
                self?.forgotButton.setTitleColor(ColorPalette.mainColor, for: .normal)
            }
        }
    }
    
    private func setupTextFields() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setupBarButtonItems() {
        let dismissButton = UIBarButtonItem(image: #imageLiteral(resourceName: "cancel"), style: .plain, target: self, action: #selector(handleDismissButton))
        dismissButton.tintColor = .white
        
        navigationItem.leftBarButtonItem = dismissButton
    }
    
    @objc func handleDismissButton() {
        onDismissTap?()
    }
    
    
    private func observeKeyboardAppearance() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(notification:)), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(notification:)), name: .UIKeyboardWillShow, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationLogin(notification:)), name: .userLoginNotification, object: nil)
    }
    
    @objc func handleNotificationLogin(notification: Notification) {
        onCompleteAuth?()
    }
    
    @objc func handleKeyboard(notification: Notification) {
        if let userInfo = notification.userInfo {
            guard let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue else { return }
            
            if notification.name == .UIKeyboardWillShow {
                scrollView.contentInset.bottom = keyboardFrame.size.height
                scrollView.scrollRectToVisible(loginButton.frame, animated: true)
                scrollView.scrollIndicatorInsets = scrollView.contentInset
            } else {
                scrollView.contentInset = .zero
                scrollView.scrollIndicatorInsets = scrollView.contentInset
            }
        }
    }
    
    private func addGestureForHideKeyBoard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    private func setupViews() {
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgotButton])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        
        contentView.addSubview(stackView)
        
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        forgotButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        contentView.addSubview(signUpButton)
        
        signUpButton.safeBottomAnchor.constraint(equalTo: contentView.safeBottomAnchor, constant: -10).isActive = true
        signUpButton.safeLeftAnchor.constraint(equalTo: contentView.safeLeftAnchor, constant: 20).isActive = true
        signUpButton.safeRightAnchor.constraint(equalTo: contentView.safeRightAnchor, constant: -20).isActive = true
    }
}


extension LoginController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
