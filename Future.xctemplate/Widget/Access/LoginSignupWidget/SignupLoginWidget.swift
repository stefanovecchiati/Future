//
//  SignupWidgetCollectionViewCell.swift
//  Heldev
//
//  Created by stefano vecchiati on 08/11/2018.
//  Copyright © 2018 com.stefanovecchiati. All rights reserved.
//

import UIKit


class SignupLoginWidget: BaseCollectionViewCell {
    
    @IBOutlet weak var loginSignupButton: GeneralButton!
    @IBOutlet weak var forgotPassword: UnderlineButton!
    
    @IBOutlet var textFieldViews: [TextFieldView]!
    
    override func setupCell() {
        super.setupCell()
        
    }
    
    func setConstraint() {
        
        guard let baseModel = baseModel else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let navigationBarHeight = ( UIApplication.topViewController()?.navigationController?.navigationBar.bounds.height ?? 0 ) + UIApplication.shared.statusBarFrame.height
        
        let tabBarHeight = UIApplication.topViewController()?.tabBarController?.tabBar.bounds.height ?? 0
        
        let widthConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width)
        widthConstraint.priority = .defaultHigh
        
        let heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height - ( (baseModel.hideNavigationBar ? UIApplication.shared.statusBarFrame.height : navigationBarHeight) + tabBarHeight ))
        heightConstraint.priority = .defaultHigh
        
        self.addConstraints([widthConstraint, heightConstraint])
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        setConstraint()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        guard let cellStruct = selectedStruct as? SignupLoginModel else { return }
        
        switch cellStruct.access {
        case .login?:
            forgotPassword.setTitle(title: R.string.localizable.kForgotPassword())
            loginSignupButton.styleEmpty(andTitle: R.string.localizable.kLogin())
            for textFieldView in textFieldViews {
                switch textFieldView.tag {
                case 0:
                    textFieldView.isHidden = true
                case 1:
                    textFieldView.isHidden = false
                    
                    textFieldView.setup(lineColor: .gray, placeholder: R.string.localizable.kEmail(), keyboardType: .emailAddress)
                    
                    textFieldView.textField.becomeFirstResponder()
                case 2:
                    textFieldView.isHidden = false
                    
                    textFieldView.setup(lineColor: .gray, placeholder: R.string.localizable.kPassword(), keyboardType: .default, isSecureTextEntry: true)
                    
                default:
                    break
                }
            }
        case .signup?:
            forgotPassword.isHidden = true
            loginSignupButton.styleFull(andTitle: R.string.localizable.kSignup())
            for textFieldView in textFieldViews {
                switch textFieldView.tag {
                case 0:
                    textFieldView.isHidden = false
                    
                    textFieldView.setup(lineColor: .gray, placeholder: R.string.localizable.kEmail(), keyboardType: .emailAddress)
                    
                    textFieldView.textField.becomeFirstResponder()
                    
                case 1:
                    textFieldView.isHidden = false
                    
                    textFieldView.setup(lineColor: .gray, placeholder: R.string.localizable.kPassword(), keyboardType: .default, isSecureTextEntry: true)
                    
                case 2:
                    textFieldView.isHidden = false
                    
                    textFieldView.setup(lineColor: .gray, placeholder: R.string.localizable.kRepeatPassword(), keyboardType: .default, isSecureTextEntry: true)
                    
                default:
                    break
                }
            }
            
        case .forgetPassword?:
            forgotPassword.isHidden = true
            loginSignupButton.styleFull(andTitle: R.string.localizable.kForgotPassword())
            for textFieldView in textFieldViews {
                switch textFieldView.tag {
                case 0:
                    textFieldView.isHidden = true
                case 1:
                    textFieldView.isHidden = true
                case 2:
                    textFieldView.isHidden = false
                    
                    textFieldView.setup(lineColor: .gray, placeholder: R.string.localizable.kEmail(), keyboardType: .default, isSecureTextEntry: false)
                    
                    textFieldView.textField.becomeFirstResponder()
                    
                default:
                    break
                }
            }
        case .none:
            break
        }
    }
    
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        let viewController = ViewController(withModel: SignupLoginModel.createModel(access: .forgetPassword))
        UIApplication.topViewController()?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func accessAction(_ sender: Any) {
        
        guard let cellStruct = selectedStruct as? SignupLoginModel else { return }
        
        switch cellStruct.access {
        case .signup?:
            
            guard let email = textFieldViews.filter({$0.tag == 0}).first?.textField.text, !email.isEmpty else {
                
                UIApplication.topViewController()?.present(GeneralUtils.share.alertBuilder(title: R.string.localizable.kErorr().uppercased(), message: R.string.localizable.kNoEmail(), closeAction: {_ in }), animated: true, completion: nil)
                
                return
                
                
            }
            
            let passwords = textFieldViews.filter({$0.tag == 1 || $0.tag == 2})
            guard passwords.count == 2, let password = passwords.first?.textField.text, password == passwords.last?.textField.text else {
                UIApplication.topViewController()?.present(GeneralUtils.share.alertBuilder(title: R.string.localizable.kErorr().uppercased(), message: R.string.localizable.kInvalidPasswordOrNotMatching(), closeAction: {_ in }), animated: true, completion: nil)
                
                return
                
            }
            
            FirebaseAccess.signup(email: email, password: password) { success, isEmailVerified  in
                if success {
                    if let emailVerified = isEmailVerified, !emailVerified, let sendEmailVerification = FirebaseSettings.getObject()?.sendEmailVerification, sendEmailVerification {
                        
                        self.showAlertListenerEmailVerification()
                        
                        return
                        
                    } else {
                        self.leaveAccess()
                    }
                }
            }
        case .login?:
            
            guard let email = textFieldViews.filter({$0.tag == 1}).first?.textField.text, !email.isEmpty else {
                
                UIApplication.topViewController()?.present(GeneralUtils.share.alertBuilder(title: R.string.localizable.kErorr().uppercased(), message: R.string.localizable.kNoEmail(), closeAction: {_ in }), animated: true, completion: nil)
                
                return
                
                
            }
            
            let passwords = textFieldViews.filter({$0.tag == 2})
            guard let password = passwords.first?.textField.text else {
                
                UIApplication.topViewController()?.present(GeneralUtils.share.alertBuilder(title: R.string.localizable.kErorr().uppercased(), message: R.string.localizable.kInvalidPassword(), closeAction: {_ in }), animated: true, completion: nil)
                
                return
                
            }
            
            FirebaseAccess.login(email: email, password: password) { success, isEmailVerified in
                if success {
                    
                    if let emailVerified = isEmailVerified, !emailVerified, let sendEmailVerification = FirebaseSettings.getObject()?.sendEmailVerification, sendEmailVerification {
                        
                        self.showAlertListenerEmailVerification()
                        
                        return
                        
                    } else {
                        self.leaveAccess()
                    }
                    
                }
            }
            
        case .forgetPassword?:
            guard let email = textFieldViews.filter({$0.tag == 2}).first?.textField.text, !email.isEmpty else {
                
                UIApplication.topViewController()?.present(GeneralUtils.share.alertBuilder(title: R.string.localizable.kErorr().uppercased(), message: R.string.localizable.kNoEmail(), closeAction: {_ in }), animated: true, completion: nil)
                
                return
            }
            
            
            FirebaseAccess.resetPassword(email: email, completion: { success in
                if success {
                    
                    
                    UIApplication.topViewController()?.present(GeneralUtils.share.alertBuilder(title: R.string.localizable.kEmailSent(), message: R.string.localizable.kEmailSentDescription(), closeAction: {_ in
                        UIApplication.topViewController()?.navigationController?.popViewController(animated: true)
                    }), animated: true, completion: nil)
                    
                    
                }
            })
            
        case .none:
            break
        }
        
    }
    
    private func showAlertListenerEmailVerification() {
        let alert = GeneralUtils.share.alertBuilder(title: R.string.localizable.kStandby(), message: R.string.localizable.kStandbyDescription(), style: .actionSheet, withAction: true, actionTitle: [R.string.localizable.kStandbyAction(), R.string.localizable.kResendEmail()] , closeAction: { index in
            
            switch index {
            case 0:
                FirebaseAccess.removeUserListenerVerificationEmail()
                FirebaseAccess.logout(completion: { success in
                    UIApplication.topViewController()?.navigationController?.popViewController(animated: true)
                })
                
            case 1:
                
                self.showAlertListenerEmailVerification()
                
                FirebaseAccess.sendEmailVerification(completion: { _ in
                    
                })
            default:
                break
                
            }
            
        })
        
        FirebaseAccess.userListenerVerificationEmail(completion: { success in
            if success {
                
                alert.dismiss(animated: true, completion: {
                    
                    self.leaveAccess()
                    
                })
            }
        })
        
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    
    private func leaveAccess() {
        let viewController = ViewController(withModel: Model.createModel())
        UIApplication.shared.delegate?.window??.rootViewController = BaseNavigationController(rootViewController: viewController)
        UIApplication.shared.delegate?.window??.makeKeyAndVisible()
    }
    
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            self.constraints[self.constraints.count - 1].constant = self.constraints[self.constraints.count - 1].constant - keyboardHeight
            
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        textFieldViews.forEach { (textFieldView) in
            textFieldView.textField.resignFirstResponder()
        }
    }
    
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
    
}
