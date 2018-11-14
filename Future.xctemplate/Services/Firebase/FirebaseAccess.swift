//
//  FirebaseAccess.swift
//  Heldev
//
//  Created by stefano vecchiati on 08/11/2018.
//  Copyright © 2018 com.stefanovecchiati. All rights reserved.
//

import UIKit
import Firebase

class FirebaseAccess: NSObject {
    
    static func initFirebase() {
        
        FirebaseApp.configure()
        
    }
    
    private static var verificationEmailTimer : Timer!
    
    static func login(email: String, password: String, completion: @escaping (Bool, Bool?) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (data, error) in
            guard let user = data?.user else {
                
                UIApplication.topViewController()?.present(GeneralUtils.share.alertBuilder(title: R.string.localizable.kErorr(), message: error?.localizedDescription, closeAction: {_ in
                    completion(false, nil)
                }), animated: true, completion: nil)
                
                
                return
                
            }
            
            completion(true, user.isEmailVerified)
        }
        
    }
    
    static func checkLoggeduser(completion: @escaping (Bool, Bool?) -> ()) {
        if let user = Auth.auth().currentUser {
            user.reload(completion: { (error) in
                if error != nil {
                    UIApplication.topViewController()?.present(GeneralUtils.share.alertBuilder(title: R.string.localizable.kErorr(), message: error?.localizedDescription, closeAction: {_ in
                        completion(false, nil)
                    }), animated: true, completion: nil)
                } else {
                    completion(true, user.isEmailVerified)
                }
            })
        } else {
            completion(false, nil)
        }
    }
    
    static func logout(completion: @escaping (Bool) -> ()) {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            completion(true)
        } catch let error as NSError {
            print ("Error signing out: %@", error)
            
            UIApplication.topViewController()?.present(GeneralUtils.share.alertBuilder(title: R.string.localizable.kErorr(), message: error.localizedDescription, closeAction: {_ in
                completion(false)
            }), animated: true, completion: nil)
            
            
        }
    }
    
    static func signup(email: String, password: String, completion: @escaping (Bool, Bool?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            // ...
            guard let user = authResult?.user else {
                
                UIApplication.topViewController()?.present(GeneralUtils.share.alertBuilder(title: R.string.localizable.kErorr(), message: error?.localizedDescription, closeAction: {_ in
                    completion(false, nil)
                }), animated: true, completion: nil)
                
                return
                
            }
            
            if !user.isEmailVerified {
                sendEmailVerification(completion: { success in
                    if success {
                        completion(true, user.isEmailVerified)
                    } else {
                        completion(false, nil)
                    }
                })
            } else {
                completion(true, user.isEmailVerified)
            }
            
            
        }
        
    }
    
    static func sendEmailVerification(completion: @escaping (Bool) -> ()) {
        Auth.auth().currentUser?.sendEmailVerification { (error) in
            guard let error = error else {
                
                completion(true)
                return
            }
            
            UIApplication.topViewController()?.present(GeneralUtils.share.alertBuilder(title: R.string.localizable.kErorr(), message: error.localizedDescription, closeAction: {_ in
                completion(false)
            }), animated: true, completion: nil)
        }
    }
    
    static func resetPassword(email: String, completion: @escaping (Bool) -> ()) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                UIApplication.topViewController()?.present(GeneralUtils.share.alertBuilder(title: R.string.localizable.kErorr(), message: error.localizedDescription, closeAction: {_ in 
                    completion(false)
                }), animated: true, completion: nil)
                
                return
            }
            
            completion(true)
        }
    }
    
    
    
    static func userListenerVerificationEmail(completion: @escaping (Bool) -> ()) {
        
        verificationEmailTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            if timer.isValid {
                if let user = Auth.auth().currentUser {
                    user.reload(completion: { (error) in
                        if error != nil {
                            debugPrint(error!.localizedDescription)
                        } else {
                            if user.isEmailVerified {
                                removeUserListenerVerificationEmail()
                                completion(true)
                            }

                        }
                    })
                }
            } else {
                completion(false)
            }
        }
        
    }
    
    static func removeUserListenerVerificationEmail() {
        verificationEmailTimer.invalidate()
    }

}
