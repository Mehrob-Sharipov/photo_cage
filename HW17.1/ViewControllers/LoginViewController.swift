//
//  ViewController.swift
//  HW17.1
//
//  Created by Sharipov Mehrob on 28.06.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var myLable: UILabel!
    
   private var timer = Timer()
    private let visualEffectView = UIVisualEffectView()
    
   private var user: User = .init(login: "", password: "", registration: false)
    
   private var responder: Bool = true {
        didSet {
            if responder {
                passwordTextField.resignFirstResponder()
            } else {
                passwordTextField.becomeFirstResponder()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = UserDefaults.standard.value(User.self, forKey: "user") {
            self.user = user
        }
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        loginTextField.becomeFirstResponder()
        
        
        
        if !user.registration {
            visualEffect()
            firstRegistrationAlert()
        }
    }
    
    
  private  func visualEffect(){
        visualEffectView.effect = UIBlurEffect(style: .systemChromeMaterialDark)
        visualEffectView.frame = view.bounds
        view.addSubview(visualEffectView)
    }
    
    
  private  func firstRegistrationAlert(){
        
        if !user.registration {
            showAlertWithTextField { (password: String, login: String) in
                self.user = User(login: login, password: password, registration: true)
                
                UserDefaults.standard.set(encodable: self.user, forKey: "user")
                
                self.timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { Timer in
                    UIView.animate(withDuration: 0.07) {
                        if self.visualEffectView.alpha > 0.1 {
                            self.visualEffectView.alpha -= 0.1
                        } else {
                            self.visualEffectView.isHidden = true
                            self.timer.invalidate()
                        }
                    }
                }
            }
        }
    }
    
    
   private func checkLogin(){
        guard let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? CollectionViewController else {return}
        
        secondViewController.navigationItem.setHidesBackButton(true, animated: true)
        
        if loginTextField.text == self.user.login && passwordTextField.text == self.user.password {
            enterButton.backgroundColor = .green
            
            UIView.animate(withDuration: 1) {
                self.visualEffectView.isHidden = false
                self.visualEffectView.alpha = 1
                self.enterButton.backgroundColor = .clear
            }completion: { _ in
                self.navigationController?.pushViewController(secondViewController, animated: true)
            }
            
        } else {
            myLable.text = "Wrong login or password"
            myLable.textColor = .red
        }
    }
    
    
    
    
    @IBAction func enterButtonPressed(_ sender: Any) {
        checkLogin()
    }
    
}










extension LoginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch responder {
        case true:
            responder = false
            loginTextField.resignFirstResponder()
        case false:
            responder = true
        }
        return true
    }
    
}


