//
//  Extension+AlertController.swift
//  HW17.1
//
//  Created by Sharipov Mehrob on 28.06.2023.
//

import Foundation
import UIKit


extension UIViewController {
    
    func showAlertWithTextField(completion: @escaping ((password: String, login: String)) -> ()) {
        
        
        
        let alertController = UIAlertController(title: "Регистрация" , message: nil, preferredStyle: .alert)
        
        
        alertController.addTextField() { LoginTextField in
            LoginTextField.placeholder = "Login"
        }
        
        alertController.addTextField() { PaswordTextField in
            PaswordTextField.isSecureTextEntry = true
            PaswordTextField.placeholder = "Pasword"
        }
        
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            
            if let loginText = alertController.textFields?.first?.text,
               let passwordText = alertController.textFields?.last?.text {
                
                completion((password: passwordText, login: loginText))
            }
        }
        
        okAction.isEnabled = false
        
        
        
        
        
        //        func isValidEmail(testStr:String) -> Bool {
        //            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        //            if let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx) as NSPredicate? {
        //                return emailTest.evaluate(with: testStr)
        //            }
        //            return false
        //        }
        
        
        NotificationCenter.default.addObserver(
            forName: UITextField.textDidChangeNotification,
            object: alertController.textFields?.first,
            queue: .main
        ) { notification in
            
            if let loginText = alertController.textFields?.first?.text,
               let passwordText = alertController.textFields?.last?.text {
                if loginText.count < 2 && passwordText.count < 2 {
                    alertController.title = "Wrong format"
                    okAction.isEnabled = false
                }else {
                    alertController.title = "Corrent format"
                    okAction.isEnabled = true
                }
            }
        }
        
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}
